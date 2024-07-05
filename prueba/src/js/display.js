class Display {
  #content
  #maxLength
  #displayDOM
  #operatorButtons
  #numbersButtons
  #plusMinusButton
  #decimalButton
  #equalButton

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
  }

  setContent (newContent) {
    if (
      newContent === Infinity ||
      newContent === -Infinity ||
      Number.isNaN(newContent) ||
      newContent === undefined ||
      newContent == null ||
      newContent.toString().length > this.#maxLength
    ) {
      this.#content = 'ERROR'
    } else {
      this.#content = newContent.toString()
    }
    console.log(newContent)
    this.#displayDOM.textContent = this.#content
    this.checkDisplayStatusFromContent()
  }

  checkDisplayStatusFromContent () {
    if (this.#content === '0') {
      console.log('entra en 0')
      this.updateStatusButtons(this.#numbersButtons, true)
      this.updateStatusButtons([this.#decimalButton], true) // ultimo cambio (es una contradicion??)
      this.updateStatusButtons(this.#operatorButtons, true)
      this.updateStatusButtons([this.#equalButton], true)
      this.updateStatusButtons([this.#plusMinusButton], false)
    } else if (this.#content.includes('.')) {
      this.updateStatusButtons([this.#decimalButton], false)
      this.updateStatusButtons([this.#plusMinusButton], true)
      if (this.#content.indexOf('.') === this.#content.length - 1) { // si el punto esta en la ultima pos
        this.updateStatusButtons([this.#equalButton], false)
        this.updateStatusButtons(this.#operatorButtons, false)
        this.updateStatusButtons([this.#plusMinusButton], false)

        if (this.#content.length === 9) { // punto en la ultima posicion
          this.updateStatusButtons(this.#numbersButtons, false)
          console.log('ultimo digito 9 punto')
          // desactivar numeros
        } else {
          this.updateStatusButtons(this.#numbersButtons, true)
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
      this.updateStatusButtons([this.#plusMinusButton], true) // ultimo cambio
    } else {
      this.updateStatusButtons(this.#numbersButtons, true)
      this.updateStatusButtons([this.#decimalButton], true)
      this.updateStatusButtons(this.#operatorButtons, true)
      this.updateStatusButtons([this.#equalButton], true)
      this.updateStatusButtons([this.#plusMinusButton], true)
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
}
