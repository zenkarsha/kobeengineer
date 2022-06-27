class FormView

  main:
    language: (options, view = '') ->
      @dom = $('#code_language')
      for key of options
        view += @__option key, options[key], 'brainfuck'
      @dom.html view
    theme: (options, view = '') ->
      @dom = $('#code_theme')
      for key of options
        view += @__option key, options[key], 'vim'
      @dom.html view
    __option: (value, name, default_value, selected = '') ->
      if value is default_value then selected = ' selected'
      """
        <option value="#{ value }"#{ selected }>#{ name }</option>
      """

global.FormView = new FormView
module.exports = FormView
