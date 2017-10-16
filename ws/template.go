package main

import (
  "net/http"
  "log"
  "html/template"
  "os"
  "os/exec"
  "io/ioutil"
  "strings"
  "bytes"
)

const RADIO_BUTTON int = 0
const CHECK_BOX int = 1

type RadioButton struct {
  Name       string
  Value      string
  IsDisabled bool
  IsChecked  bool
  Text       string
}

type CheckBox struct {
  Name       string
  Value      string
  IsDisabled bool
  IsChecked  bool
  Text       string
}

type PageVariables struct {
  PageTitle        string
  PageRadioButtons []RadioButton
  PageCheckBoxes   []CheckBox
  Pergunta         string
  Answer           []string
}

type Question struct{
  Enunciado  string
  Tipo       int
  Opcoes     []string
  Valores    []string
}

var questoes []Question = []Question{
  //Question{"Selecione os sintomas", RADIO_BUTTON, []string{"Odio frequente", "Raiva assidua",  "Olar bom dia"}, []string{"odio", "raiva",  "bomdia"}},
  Question{"Qual a idade do seu bebe?", RADIO_BUTTON, []string{"1 ano ou menos", "Maior que 1 ano"}, []string{"menos de 1 ano", "mais de 1 ano"}},
  Question{"Caso seu bebê tenha 1 ano ou menos, ele tem entre 0 e 6 meses?", RADIO_BUTTON, []string{"Sim", "Não"}, []string{"menos de 6 meses", ""}},
  Question{"Seu bebê está com febre?", RADIO_BUTTON, []string{"Sim", "Não"}, []string{"febre", ""}},
  Question{"Seu bebê está com diarréia?", RADIO_BUTTON, []string{"Sim", "Não"}, []string{"diarreia", ""}},
  Question{"Seu bebê tem sonolência?", RADIO_BUTTON, []string{"Sim", "Não"}, []string{"sonolencia", ""}},
}

var ctrl int = 0

func main() {
  http.HandleFunc("/", Reset)
  http.HandleFunc("/selected", NextQuestion)
  http.HandleFunc("/reset", Reset)
  log.Fatal(http.ListenAndServe(":8080", nil))
}

func Reset(w http.ResponseWriter, r *http.Request){
  ctrl = 0
  log.Print("---- RESET ----")
  os.Remove("../sintomas.txt")
  os.Remove("../output.txt")
  http.Redirect(w, r, "selected", 301)
}

func NextQuestion(w http.ResponseWriter, r *http.Request){
  r.ParseForm()

  log.Print("---- NOVA PERGUNTA ----")

  mp := r.Form
  strs := mp["sintoma"]

  for _,v:=range strs{
    log.Print("Respostas: ", v)
    var buf bytes.Buffer
    buf.WriteString("'")
    buf.WriteString(v)
    buf.WriteString("'.\n")
    f, err := os.OpenFile("../sintomas.txt", os.O_APPEND|os.O_WRONLY, 0600)
    if err != nil {
      f, _ = os.Create("../sintomas.txt")
    }
    defer f.Close()
    f.WriteString(buf.String())
    // ioutil.WriteFile("sintomas.txt", buf.Bytes(), 0600)
  }

  var Diag []string

  if len(strs)>0{
    Diag = TryAnswer()
  }

  MyCheckBoxes := []CheckBox{}
  MyRadioButtons := []RadioButton{}
  Enunciado := ""

  if ctrl < len(questoes){
    questao := questoes[ctrl]
    ctrl++

    opcoes := questao.Opcoes
    valores := questao.Valores

    if questao.Tipo == CHECK_BOX{
      for i := range opcoes{
        MyCheckBoxes = append(MyCheckBoxes, CheckBox{"sintoma", valores[i], false, false, opcoes[i]})
      }
    }else{
      for i := range opcoes{
        MyRadioButtons = append(MyRadioButtons, RadioButton{"sintoma", valores[i], false, false, opcoes[i]})
      }
    }

    Enunciado = questao.Enunciado
  }else{
    Enunciado = "Resultado"
    // cmd := exec.Command("cmd", "/C", "cd .. & base_de_dados_list.pl")
    // cmd.Start()
  }

  MyPageVariables := PageVariables{
    PageTitle: "Sistema de Diagnósticos",
    PageCheckBoxes: MyCheckBoxes,
    PageRadioButtons: MyRadioButtons,
    Pergunta: Enunciado,
  }

  if len(Diag) > 0{
    MyPageVariables.Answer = Diag
  }


  // generate page by passing page variables into template
  t, err := template.ParseFiles("index.html") //parse the html file homepage.html
  if err != nil { // if there is an error
    log.Print("template parsing error: ", err) // log it
  }

  err = t.Execute(w, MyPageVariables) //execute the template and pass it the HomePageVars struct to fill in the gaps
  if err != nil { // if there is an error
    log.Print("template executing error: ", err) //log it
  }
}

func TryAnswer() ([]string){
  os.Remove("../output.txt")
  cmd := exec.Command("cmd", "/C", "cd .. & base_de_dados_list.pl")
  cmd.Start()

  TEST:
  if fi, err := os.Stat("../output.txt"); os.IsNotExist(err) ||  fi.Size() == 0 {
    goto TEST
  }

  content, _ := ioutil.ReadFile("../output.txt")
  lines := strings.Split(string(content), "\n")

  for i := range lines{
    log.Print(lines[i])
  }

  os.Remove("../output.txt")
  return lines
}
