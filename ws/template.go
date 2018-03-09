package main

import (
  "time"
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
  Question{"Qual a idade do seu bebe?", RADIO_BUTTON, []string{"1 ano ou menos", "Maior que 1 ano"}, []string{"menos de 1 ano", "mais de 1 ano"}},
  Question{"Caso seu bebê tenha 1 ano ou menos, ele tem entre 0 e 6 meses?", CHECK_BOX, []string{"Sim", "Não", "Tem mais de 1 ano"}, []string{"menos de 6 meses", "mais de 6 meses", ""}},
  Question{"Seu bebê está com febre?", RADIO_BUTTON, []string{"Sim", "Não"}, []string{"febre", ""}},
  Question{"Se sim, ela já dura dias?", CHECK_BOX, []string{"Sim", "Não", "Não está com febre"}, []string{"febre ha dias", "febre momentanea", ""}},
  Question{"Seu bebê está com diarréia?", RADIO_BUTTON, []string{"Sim", "Não"}, []string{"diarreia", ""}},
  Question{"Se sim, ela já dura 2 semanas ou mais?", CHECK_BOX, []string{"Sim", "Não", "Não está com diarréia"}, []string{"mais de 2 semanas", "ultimos 3 dias", ""}},
  Question{"Seu bebê foi recentemente medicado?", RADIO_BUTTON, []string{"Sim", "Não"}, []string{"tomou medicamento", ""}},
  Question{"Seu bebê está com incomumente irritado?", RADIO_BUTTON, []string{"Sim", "Não"}, []string{"irritabilidade", ""}},
  Question{"Seu bebê apresenta respiração ruidosa?", RADIO_BUTTON, []string{"Sim", "Não"}, []string{"respiracao ruidosa", ""}},
  Question{"Seu bebê está com tosse?", RADIO_BUTTON, []string{"Sim", "Não"}, []string{"tosse", ""}},
  Question{"Seu bebê está com o nariz escorrendo com frequência?", RADIO_BUTTON, []string{"Sim", "Não"}, []string{"coriza", ""}},
  Question{"Seu bebê tem sonolência incomum?", RADIO_BUTTON, []string{"Sim", "Não"}, []string{"sonolencia", ""}},
  Question{"Seu bebê está com vômito?", RADIO_BUTTON, []string{"Sim", "Não"}, []string{"vomito", ""}},
  Question{"Se sim, o vômito tem aparência esverdeada?", CHECK_BOX, []string{"Sim", "Não", "Não está com vômito"}, []string{"vomito verde", "", ""}},
  Question{"Seu bebê possui algum dos sintomas abaixo? Marque-os.", CHECK_BOX, []string{"Crises de Tosse", "Respiração Acelerada", "Pele Azulada", "Pele Sarapintada", "Dificuldade para respirar"}, []string{"crises", "respiracao acelerada", "pele azulada", "pele sarapintada", "dificuldade para respirar"}},
  Question{"Seu bebê apresenta erupções (feridas) na pele?", RADIO_BUTTON, []string{"Sim", "Não"}, []string{"erupcoes na pele", ""}},
  Question{"Se sim, como são essas erupções?", CHECK_BOX, []string{"Intensamente vemelhas", "Criam bolhas e secam com casquinha", "São suaves (claras)", "São elevadas", "Estão apenas nas bochechas", "Estão no rosto ou tronco", "Não há erupções"}, []string{"erupcao vermelha", "macnchas criam bolhas e secam em crostas", "erupcao suave", "manchas elevadas", "erupcao nas bochechas", "rosto ou tronco", ""}},
  Question{"Seu bebê apresenta manchas rosas achatadas pelo corpo?", RADIO_BUTTON, []string{"Sim", "Não"}, []string{"manchas rosas achatadas", ""}},
  Question{"Se sim, essas manchas somem ao serem apertadas?", CHECK_BOX, []string{"Sim", "Não", "Não há manchas"}, []string{"desaparecem quando apertadas", "nao desaparecem quando apertadas", ""}},
  Question{"Seu bebê está com algum dos sintomas abaixo? Marque-os.", CHECK_BOX, []string{"Chora ao puxar a orelha ou ao tocá-la", "Está com um lado da face inchada", "Está com os olhos vermelhos"}, []string{"chora ao puxar orelha", "face inchada", "olhos vermelhos"}},
  Question{"Seu bebê possui algum dos sintomas abaixo? Marque-os.", CHECK_BOX, []string{"Dores Abdominais", "Olhos Afundados", "Língua Seca", "Pele Descascada"}, []string{"dores abdominais", "olhos afundados", "lingua seca", "pele descascada"}},
  Question{"Seu bebê possui algum dos sintomas abaixo? Marque-os.", CHECK_BOX, []string{"Garganta Inflamada", "Dor de Garganta", "Pescoço duro", "Dor de Cabeça", "Pouco Apetite", "Dor nos Braços ou Pernas", "Mãos ou pés frios"}, []string{"garganta inflamada", "dor de garganta", "pescoco duro", "dor de cabeca", "pouco apetite", "dor nos bracos ou pernas", "maos ou pes frios"}},
  Question{"Seu bebê está rejeitando ser alimentado?", RADIO_BUTTON, []string{"Sim", "Não"}, []string{"rejeita ser alimentado", "aceita ser alimentado"}},
  Question{"Seu bebê está conseguindo ser amamentado sem dificuldade?", RADIO_BUTTON, []string{"Sim", "Não"}, []string{"leite com dificuldade", ""}},
  Question{"Seu bebê está rejeitando algum tipo de alimento?", CHECK_BOX, []string{"Líquidos", "Sólidos"}, []string{"rejeita liquidos", "rejeita comida solida"}},
  Question{"Seu bebê experimentou algum alimento recentemente?", RADIO_BUTTON, []string{"Sim", "Não"}, []string{"alimento novo", ""}},
  Question{"Seu bebê tem tomado sucos ou extratos de polpa em excesso?", RADIO_BUTTON, []string{"Sim", "Não"}, []string{"sucos ou polpas excesso", ""}},
  Question{"Seu bebê está sofrendo dores há mais de seis horas?", RADIO_BUTTON, []string{"Sim", "Não"}, []string{"dor por 6 horas", ""}},
  Question{"Em relação ao xixi, seu bebê...", CHECK_BOX, []string{"Está urinando pouco.", "Com dor ao urinar.", "Está com a urina escura."}, []string{"pouca urina", "dor ao urinar", "urina escura"}},
  Question{"Em relação às fezes, seu bebê...", CHECK_BOX, []string{"Está com as fezes pálidas.", "Tem fezes com pedacinhos reconhecíveis de comida.", "Esteve recentemente constipado."}, []string{"fezes palidas", "pedacinhos reconheciveis", "constipado"}},
  Question{"Seu bebê...", CHECK_BOX, []string{"Foi exposto ao sol por longo período.", "Está com muita roupa.", "Está em um ambiente muito quente."}, []string{"muito tempo no sol", "muita roupa", "recinto quente"}},
  Question{"Seu bebê...", CHECK_BOX, []string{"Está agitado.", "Começou apresentar os sintomas após uma viagem.", "Passou por algum evento estressante.", "Sofreu alguma pancada."}, []string{"agitado", "apos viagem", "evento estressante", "sofreu pancada"}},
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
    if v!=""{
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
    }
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


     time.Sleep(3000 * time.Millisecond)

  content, _ := ioutil.ReadFile("../output.txt")
  lines := strings.Split(string(content), "\n")

  for i := range lines{
    log.Print(lines[i])
  }

  os.Remove("../output.txt")
  return lines
}
