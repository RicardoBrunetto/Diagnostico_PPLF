package main

import (
  "net/http"
  "log"
  "html/template"
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
  Question{"Selecione os sintomas", RADIO_BUTTON, []string{"Odio frequente", "Raiva assidua",  "Olar bom dia"}, []string{"odio", "raiva",  "bomdia"}},
  Question{"Selecione os sintomas", CHECK_BOX, []string{"Caganeira", "Diarréia Explosiva",  "Pão com ovo"}, []string{"caganeira", "raaehuaehuaeiva",  "paocomovo"}},
}

var ctrl int = 0

func main() {
  http.HandleFunc("/", NextQuestion)
  http.HandleFunc("/selected", NextQuestion)
  http.HandleFunc("/reset", Reset)
  log.Fatal(http.ListenAndServe(":8080", nil))
}


func DisplayQuestions(w http.ResponseWriter, r *http.Request){
  // Display some radio buttons to the user

  Title := "Sistema de Diagnosticos"


  MyPageVariables := PageVariables{
    PageTitle: Title,
  }

  t, err := template.ParseFiles("index.html") //parse the html file homepage.html
  if err != nil { // if there is an error
    log.Print("template parsing error: ", err) // log it
  }

  err = t.Execute(w, MyPageVariables) //execute the template and pass it the HomePageVars struct to fill in the gaps
  if err != nil { // if there is an error
    log.Print("template executing error: ", err) //log it
  }

}

func Reset(w http.ResponseWriter, r *http.Request){
  ctrl = 0
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
  }

  MyPageVariables := PageVariables{
    PageTitle: "Sistema de Diagnosticos",
    PageCheckBoxes: MyCheckBoxes,
    PageRadioButtons: MyRadioButtons,
    Pergunta: Enunciado,
    Answer : strs,
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
