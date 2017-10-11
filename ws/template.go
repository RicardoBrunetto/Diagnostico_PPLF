package main

import (
  "net/http"
  "log"
  "html/template"
  "io/ioutil"
  "os"
  "os/exec"
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
  Answer           string
}

type Question struct{
  Enunciado  string
  Tipo       int
  Opcoes     []string
  Valores    []string
}

var questoes []Question = []Question{
  //Question{"Selecione os sintomas", RADIO_BUTTON, []string{"Odio frequente", "Raiva assidua",  "Olar bom dia"}, []string{"odio", "raiva",  "bomdia"}},
  Question{"Selecione os sintomas", CHECK_BOX, []string{"Tosse", "Vomito sem Diarréia",  "Coriza"}, []string{"tosse", "vomito sem diarreia",  "coriza"}},
  Question{"Selecione os sintomas", CHECK_BOX, []string{"Sonolência", "Irritabilidade",  "Caganeira"}, []string{"sonolencia", "irritabilidade",  "caganeira"}},
}

var ctrl int = 0

func main() {
  //http.HandleFunc("/", Reset)
  http.HandleFunc("/selected", NextQuestion)
  http.HandleFunc("/reset", Reset)
  log.Fatal(http.ListenAndServe(":8080", nil))
}

func Reset(w http.ResponseWriter, r *http.Request){
  ctrl = 0
  os.Remove("../sintomas.txt")
  os.Remove("../output.txt")
  http.Redirect(w, r, "selected", 301)
}

func NextQuestion(w http.ResponseWriter, r *http.Request){
  r.ParseForm()
  // r.Form is now either
  // map[sintoma:[cats]] OR
  // map[sintoma:[dogs]]
  // so get the animal which has been selected


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

  Diag:=""

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
    PageTitle: "Sistema de Diagnosticos",
    PageCheckBoxes: MyCheckBoxes,
    PageRadioButtons: MyRadioButtons,
    Pergunta: Enunciado,
  }

  if Diag != ""{
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

func TryAnswer() (string){
  cmd := exec.Command("cmd", "/C", "cd .. & base_de_dados_list.pl")
  cmd.Start()

  TEST:
  if _, err := os.Stat("../output.txt"); os.IsNotExist(err) {
    goto TEST
  }

  dat, _ := ioutil.ReadFile("../output.txt")
  log.Print(string(dat))
  os.Remove("../output.txt")
  return string(dat)
}
