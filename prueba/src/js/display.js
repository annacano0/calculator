class Display {
  #content
  #maxLength
  #displayDOM
  #operatorButtons
  #numbersButtons
  #plusMinusButton
  #decimalButton
  #equalButton
  #currentOperator

  constructor (
    maxLength,
    operatorsButtons,
    numbersButtons,
    plusMinusButton,
    decimalButton,
    equalButton
  ) {
    this.#content = ''
    this.#maxLength = maxLength
    this.#displayDOM = document.getElementById('display')
    this.#operatorButtons = operatorsButtons
    this.#numbersButtons = numbersButtons
    this.#plusMinusButton = plusMinusButton
    this.#decimalButton = decimalButton
    this.#equalButton = equalButton
    this.#currentOperator = ''

  }

  setContent (newContent) {
    let newContentToString = newContent.toString()
    let newContentToNumber = Number(newContent)
    if (
      newContentToNumber === Infinity ||
      newContentToNumber === -Infinity ||
      Number.isNaN(newContentToNumber) ||
      newContentToNumber === undefined ||
      newContentToNumber == null
    ) {
      this.#content = 'ERROR'
    } else if (newContentToString.length > this.#maxLength) {
      if (newContentToString.includes('.')) {
        console.log('entra en punto periodico')
        newContentToString = newContentToString.substring(0, (this.#maxLength))
        this.#content = newContentToString
      } else {
        this.#content = 'ERROR'
        console.log('entra en error length')
      }
    } else {
      this.#content = newContentToString
      console.log('entra sin error')
    }
    this.#displayDOM.textContent = this.#content

    this.checkDisplayStatusFromContent()
    if(this.#currentOperator !== ''){
      this.checkOperatorStatusFromCurrentOperator()
    }
  }

  checkDisplayStatusFromContent () {
    if (this.#content === '0') {
      console.log('entra en 0')
      this.updateStatusButtons(this.#numbersButtons, true)
      this.updateStatusButtons([this.#decimalButton], true)//esto es una contradiccion
      this.updateStatusButtons(this.#operatorButtons, true)
      this.updateStatusButtons([this.#equalButton], true)
      this.updateStatusButtons([this.#plusMinusButton], true) //deberia ser false
    } else if (this.#content.includes('.')) {
      this.updateStatusButtons([this.#decimalButton], false)
      this.updateStatusButtons([this.#plusMinusButton], true)
      if (this.#content.indexOf('.') === this.#content.length - 1) { // si el punto esta en la ultima pos y no es mayor a 9
        this.updateStatusButtons([this.#equalButton], false)
        this.updateStatusButtons(this.#operatorButtons, false)
        this.updateStatusButtons([this.#plusMinusButton], false)

        if (this.#content.length === 9) { // punto en la ultima posicion
          this.updateStatusButtons(this.#numbersButtons, false)
          console.log('ultimo digito 9 punto')
          // desactivar numeros
        } else {
          this.updateStatusButtons(this.#numbersButtons, true)
          this.updateStatusButtons(this.#operatorButtons, false)
          console.log('ultimo digito punto no 9')
          // Activar numeros
        }
      } else { // no esta en la ultima posicion
        this.updateStatusButtons(this.#operatorButtons, true)
        this.updateStatusButtons([this.#equalButton], true)
        if (this.#content.length === 9) { // punto en la ultima posicion
          this.updateStatusButtons(this.#numbersButtons, false)
          this.updateStatusButtons([this.#plusMinusButton], false)
          console.log('no acaba en punto mide 9')
          // desactivar numeros
        } else {
          this.updateStatusButtons(this.#numbersButtons, true)
          console.log('no acaba en punto no mide 9')
          // Activar numeros
        }
      }
    } else if (this.#content.length === 9) {
      this.updateStatusButtons(this.#numbersButtons, false)
      this.updateStatusButtons([this.#decimalButton], false)
      this.updateStatusButtons(this.#operatorButtons, true)
      this.updateStatusButtons([this.#equalButton], true)
      this.updateStatusButtons([this.#plusMinusButton], false)
    } else if (this.#content === 'ERROR') {
      this.updateStatusButtons(this.#numbersButtons, false)
      this.updateStatusButtons([this.#decimalButton], false)
      this.updateStatusButtons(this.#operatorButtons, false)
      this.updateStatusButtons([this.#equalButton], false)
      this.updateStatusButtons([this.#plusMinusButton], true)
    } else {
      this.updateStatusButtons(this.#numbersButtons, true)
      this.updateStatusButtons([this.#decimalButton], true)
      this.updateStatusButtons(this.#operatorButtons, true)
      this.updateStatusButtons([this.#equalButton], true)
      this.updateStatusButtons([this.#plusMinusButton], true)
      console.log("entra en el else")
    }
  }

  setOperator (newOperator) {
    this.#currentOperator=newOperator
  } 

  checkOperatorStatusFromCurrentOperator(){
    this.updateStatusButtons(this.#operatorButtons, true)
    for (let i = 0; i < this.#operatorButtons.length; i++) {
      if (this.#operatorButtons[i].getAttribute('value') === this.#currentOperator) {
        this.updateStatusButtons([this.#operatorButtons[i]], false)
      }
    } 
  }

  updateStatusButtons (buttons, state) {
    for (let i = 0; i < buttons.length; i++) {
      if (state) {
        buttons[i].classList.remove('disabled')
        buttons[i].disabled = false
      } else {
        buttons[i].classList.add('disabled')
        buttons[i].disabled = true
      }
    }
  }

  resetDisplay(){
    this.updateStatusButtons(this.#numbersButtons, true)
    this.updateStatusButtons([this.#decimalButton], true)
    this.updateStatusButtons(this.#operatorButtons, true)
    this.updateStatusButtons([this.#equalButton], true)
    this.updateStatusButtons([this.#plusMinusButton], true)
    this.#currentOperator=''
  }
}
