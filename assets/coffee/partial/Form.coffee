class Form

  constructor: ->
    @data = {}
    @CODE_LANG = {
      'abap': 'ABAP'
      'abnf': 'ABNF'
      'adl': 'ADL'
      'antlr': 'ANTLR'
      'antlr-as': 'ANTLR With ActionScript Target'
      'antlr-csharp': 'ANTLR With C# Target'
      'antlr-cpp': 'ANTLR With CPP Target'
      'antlr-java': 'ANTLR With Java Target'
      'antlr-objc': 'ANTLR With ObjectiveC Target'
      'antlr-perl': 'ANTLR With Perl Target'
      'antlr-python': 'ANTLR With Python Target'
      'antlr-ruby': 'ANTLR With Ruby Target'
      'apl': 'APL'
      'as': 'ActionScript'
      'as3': 'ActionScript 3'
      'ada': 'Ada'
      'agda': 'Agda'
      'aheui': 'Aheui'
      'alloy': 'Alloy'
      'at': 'AmbientTalk'
      'ampl': 'Ampl'
      'ng2': 'Angular2'
      'apacheconf': 'ApacheConf'
      'applescript': 'AppleScript'
      'arduino': 'Arduino'
      'aspectj': 'AspectJ'
      'asy': 'Asymptote'
      'autoit': 'AutoIt'
      'awk': 'Awk'
      'bbcode': 'BBCode'
      'bc': 'BC'
      'bnf': 'BNF'
      'bst': 'BST'
      'bugs': 'BUGS'
      'basemake': 'Base Makefile'
      'bash': 'Bash'
      'console': 'Bash Session'
      'bat': 'Batchfile'
      'befunge': 'Befunge'
      'bib': 'BibTeX'
      'blitzbasic': 'BlitzBasic'
      'blitzmax': 'BlitzMax'
      'boo': 'Boo'
      'boogie': 'Boogie'
      'brainfuck': 'Brainfuck'
      'bro': 'Bro'
      'c': 'C'
      'csharp': 'C#'
      'cpp': 'C++'
      'camkes': 'CAmkES'
      'cbmbas': 'CBM BASIC V2'
      'cfengine3': 'CFEngine3'
      'cmake': 'CMake'
      'cobol': 'COBOL'
      'cobolfree': 'COBOLFree'
      'cpsa': 'CPSA'
      'css': 'CSS'
      'css+django': 'CSS+Django/Jinja'
      'css+genshitext': 'CSS+Genshi Text'
      'css+lasso': 'CSS+Lasso'
      'css+mako': 'CSS+Mako'
      'css+myghty': 'CSS+Myghty'
      'css+php': 'CSS+PHP'
      'css+erb': 'CSS+Ruby'
      'css+smarty': 'CSS+Smarty'
      'css+mozpreproc': 'CSS+mozpreproc'
      'cuda': 'CUDA'
      'capnp': 'Cap\'n Proto'
      'capdl': 'CapDL'
      'ceylon': 'Ceylon'
      'chai': 'ChaiScript'
      'chapel': 'Chapel'
      'cheetah': 'Cheetah'
      'cirru': 'Cirru'
      'clay': 'Clay'
      'clean': 'Clean'
      'clojure': 'Clojure'
      'clojurescript': 'ClojureScript'
      'coffee-script': 'CoffeeScript'
      'cfc': 'Coldfusion CFC'
      'cfm': 'Coldfusion HTML'
      'common-lisp': 'Common Lisp'
      'componentpascal': 'Component Pascal'
      'coq': 'Coq'
      'crmsh': 'Crmsh'
      'croc': 'Croc'
      'cryptol': 'Cryptol'
      'cr': 'Crystal'
      'csound-document': 'Csound Document'
      'csound': 'Csound Orchestra'
      'csound-score': 'Csound Score'
      'cypher': 'Cypher'
      'cython': 'Cython'
      'd': 'D'
      'dtd': 'DTD'
      'dpatch': 'Darcs Patch'
      'dart': 'Dart'
      'control': 'Debian Control file'
      'sourceslist': 'Debian Sourcelist'
      'delphi': 'Delphi'
      'diff': 'Diff'
      'django': 'Django/Jinja'
      'docker': 'Docker'
      'duel': 'Duel'
      'dylan': 'Dylan'
      'dylan-console': 'Dylan session'
      'dylan-lid': 'DylanLID'
      'ebnf': 'EBNF'
      'ecl': 'ECL'
      'erb': 'ERB'
      'earl-grey': 'Earl Grey'
      'easytrieve': 'Easytrieve'
      'eiffel': 'Eiffel'
      'elixir': 'Elixir'
      'iex': 'Elixir iex session'
      'elm': 'Elm'
      'emacs': 'EmacsLisp'
      'ragel-em': 'Embedded Ragel'
      'erlang': 'Erlang'
      'erl': 'Erlang erl session'
      'evoque': 'Evoque'
      'ezhil': 'Ezhil'
      'fsharp': 'FSharp'
      'factor': 'Factor'
      'fancy': 'Fancy'
      'fan': 'Fantom'
      'felix': 'Felix'
      'fish': 'Fish'
      'flatline': 'Flatline'
      'forth': 'Forth'
      'fortran': 'Fortran'
      'fortranfixed': 'FortranFixed'
      'foxpro': 'FoxPro'
      'gap': 'GAP'
      'gas': 'GAS'
      'glsl': 'GLSL'
      'genshi': 'Genshi'
      'genshitext': 'Genshi Text'
      'pot': 'Gettext Catalog'
      'cucumber': 'Gherkin'
      'gnuplot': 'Gnuplot'
      'go': 'Go'
      'golo': 'Golo'
      'gooddata-cl': 'GoodData-CL'
      'gosu': 'Gosu'
      'gst': 'Gosu Template'
      'groff': 'Groff'
      'groovy': 'Groovy'
      'hsail': 'HSAIL'
      'html': 'HTML'
      'html+ng2': 'HTML + Angular2'
      'html+cheetah': 'HTML+Cheetah'
      'html+django': 'HTML+Django/Jinja'
      'html+evoque': 'HTML+Evoque'
      'html+genshi': 'HTML+Genshi'
      'html+handlebars': 'HTML+Handlebars'
      'html+lasso': 'HTML+Lasso'
      'html+mako': 'HTML+Mako'
      'html+myghty': 'HTML+Myghty'
      'html+php': 'HTML+PHP'
      'html+smarty': 'HTML+Smarty'
      'html+twig': 'HTML+Twig'
      'html+velocity': 'HTML+Velocity'
      'http': 'HTTP'
      'haml': 'Haml'
      'handlebars': 'Handlebars'
      'haskell': 'Haskell'
      'hx': 'Haxe'
      'hexdump': 'Hexdump'
      'haxeml': 'Hxml'
      'hylang': 'Hy'
      'hybris': 'Hybris'
      'idl': 'IDL'
      'ini': 'INI'
      'irc': 'IRC logs'
      'idris': 'Idris'
      'igor': 'Igor'
      'inform6': 'Inform 6'
      'i6t': 'Inform 6 template'
      'inform7': 'Inform 7'
      'io': 'Io'
      'ioke': 'Ioke'
      'isabelle': 'Isabelle'
      'j': 'J'
      'jags': 'JAGS'
      'jcl': 'JCL'
      'jsgf': 'JSGF'
      'json': 'JSON'
      'jsonld': 'JSON-LD'
      'json-object': 'JSONBareObject'
      'jasmin': 'Jasmin'
      'java': 'Java'
      'jsp': 'Java Server Page'
      'js': 'JavaScript'
      'js+cheetah': 'JavaScript+Cheetah'
      'js+django': 'JavaScript+Django/Jinja'
      'js+genshitext': 'JavaScript+Genshi Text'
      'js+lasso': 'JavaScript+Lasso'
      'js+mako': 'JavaScript+Mako'
      'js+myghty': 'JavaScript+Myghty'
      'js+php': 'JavaScript+PHP'
      'js+erb': 'JavaScript+Ruby'
      'js+smarty': 'JavaScript+Smarty'
      'javascript+mozpreproc': 'Javascript+mozpreproc'
      'julia': 'Julia'
      'jlcon': 'Julia console'
      'juttle': 'Juttle'
      'kal': 'Kal'
      'kconfig': 'Kconfig'
      'koka': 'Koka'
      'kotlin': 'Kotlin'
      'llvm': 'LLVM'
      'lsl': 'LSL'
      'lasso': 'Lasso'
      'lean': 'Lean'
      'less': 'LessCss'
      'lighty': 'Lighttpd configuration file'
      'limbo': 'Limbo'
      'lagda': 'Literate Agda'
      'lcry': 'Literate Cryptol'
      'lhs': 'Literate Haskell'
      'lidr': 'Literate Idris'
      'live-script': 'LiveScript'
      'logos': 'Logos'
      'logtalk': 'Logtalk'
      'lua': 'Lua'
      'maql': 'MAQL'
      'moocode': 'MOOCode'
      'mql': 'MQL'
      'doscon': 'MSDOS Session'
      'mxml': 'MXML'
      'make': 'Makefile'
      'mako': 'Mako'
      'mask': 'Mask'
      'mason': 'Mason'
      'mathematica': 'Mathematica'
      'matlab': 'Matlab'
      'matlabsession': 'Matlab session'
      'minid': 'MiniD'
      'modelica': 'Modelica'
      'modula2': 'Modula-2'
      'trac-wiki': 'MoinMoin/Trac Wiki markup'
      'monkey': 'Monkey'
      'monte': 'Monte'
      'moon': 'MoonScript'
      'mscgen': 'Mscgen'
      'mupad': 'MuPAD'
      'mysql': 'MySQL'
      'myghty': 'Myghty'
      'nasm': 'NASM'
      'ncl': 'NCL'
      'nsis': 'NSIS'
      'nemerle': 'Nemerle'
      'newlisp': 'NewLisp'
      'newspeak': 'Newspeak'
      'nginx': 'Nginx configuration file'
      'nim': 'Nimrod'
      'nit': 'Nit'
      'nixos': 'Nix'
      'nusmv': 'NuSMV'
      'numpy': 'NumPy'
      'ocaml': 'OCaml'
      'odin': 'ODIN'
      'objective-c': 'Objective-C'
      'objective-c++': 'Objective-C++'
      'objective-j': 'Objective-J'
      'octave': 'Octave'
      'ooc': 'Ooc'
      'opa': 'Opa'
      'openedge': 'OpenEdge ABL'
      'php': 'PHP'
      'plpgsql': 'PL/pgSQL'
      'pov': 'POVRay'
      'pacmanconf': 'PacmanConf'
      'pan': 'Pan'
      'parasail': 'ParaSail'
      'pawn': 'Pawn'
      'perl': 'Perl'
      'perl6': 'Perl6'
      'pig': 'Pig'
      'pike': 'Pike'
      'pkgconfig': 'PkgConfig'
      'postscript': 'PostScript'
      'postgresql': 'PostgreSQL SQL dialect'
      'psql': 'PostgreSQL console (psql)'
      'powershell': 'PowerShell'
      'ps1con': 'PowerShell Session'
      'praat': 'Praat'
      'prolog': 'Prolog'
      'properties': 'Properties'
      'protobuf': 'Protocol Buffer'
      'pug': 'Pug'
      'puppet': 'Puppet'
      'pypylog': 'PyPy Log'
      'python selected=selected': 'Python'
      'python3': 'Python 3'
      'py3tb': 'Python 3.0 Traceback'
      'pytb': 'Python Traceback'
      'pycon': 'Python console session'
      'qbasic': 'QBasic'
      'qml': 'QML'
      'qvto': 'QVTO'
      'rconsole': 'RConsole'
      'rebol': 'REBOL'
      'rhtml': 'RHTML'
      'spec': 'RPMSpec'
      'rql': 'RQL'
      'rsl': 'RSL'
      'racket': 'Racket'
      'ragel': 'Ragel'
      'ragel-c': 'Ragel in C Host'
      'ragel-cpp': 'Ragel in CPP Host'
      'ragel-d': 'Ragel in D Host'
      'ragel-java': 'Ragel in Java Host'
      'ragel-objc': 'Ragel in Objective C Host'
      'ragel-ruby': 'Ragel in Ruby Host'
      'raw': 'Raw token data'
      'rd': 'Rd'
      'red': 'Red'
      'redcode': 'Redcode'
      'rnc': 'Relax-NG Compact'
      'resource': 'ResourceBundle'
      'rexx': 'Rexx'
      'roboconf-graph': 'Roboconf Graph'
      'roboconf-instances': 'Roboconf Instances'
      'robotframework': 'RobotFramework'
      'rb': 'Ruby'
      'rbcon': 'Ruby irb session'
      'rust': 'Rust'
      'splus': 'S'
      'sas': 'SAS'
      'scss': 'SCSS'
      'sparql': 'SPARQL'
      'sql': 'SQL'
      'swig': 'SWIG'
      'sass': 'Sass'
      'scala': 'Scala'
      'ssp': 'Scalate Server Page'
      'scaml': 'Scaml'
      'scheme': 'Scheme'
      'scilab': 'Scilab'
      'shen': 'Shen'
      'silver': 'Silver'
      'slim': 'Slim'
      'smali': 'Smali'
      'smalltalk': 'Smalltalk'
      'smarty': 'Smarty'
      'snobol': 'Snobol'
      'snowball': 'Snowball'
      'sp': 'SourcePawn'
      'squidconf': 'SquidConf'
      'stan': 'Stan'
      'sml': 'Standard ML'
      'stata': 'Stata'
      'sc': 'SuperCollider'
      'swift': 'Swift'
      'tads3': 'TADS 3'
      'tap': 'TAP'
      'tasm': 'TASM'
      'tcl': 'Tcl'
      'tcsh': 'Tcsh'
      'tcshcon': 'Tcsh Session'
      'tex': 'TeX'
      'tea': 'Tea'
      'termcap': 'Termcap'
      'terminfo': 'Terminfo'
      'terraform': 'Terraform'
      'text': 'Text only'
      'thrift': 'Thrift'
      'todotxt': 'Todotxt'
      'rts': 'TrafficScript'
      'tsql': 'Transact-SQL'
      'treetop': 'Treetop'
      'turtle': 'Turtle'
      'twig': 'Twig'
      'ts': 'TypeScript'
      'typoscript': 'TypoScript'
      'typoscriptcssdata': 'TypoScriptCssData'
      'typoscripthtmldata': 'TypoScriptHtmlData'
      'urbiscript': 'UrbiScript'
      'vb.net': 'VB.net'
      'vcl': 'VCL'
      'vclsnippets': 'VCLSnippets'
      'vctreestatus': 'VCTreeStatus'
      'vgl': 'VGL'
      'vala': 'Vala'
      'velocity': 'Velocity'
      'vim': 'VimL'
      'wdiff': 'WDiff'
      'whiley': 'Whiley'
      'x10': 'X10'
      'xml': 'XML'
      'xml+cheetah': 'XML+Cheetah'
      'xml+django': 'XML+Django/Jinja'
      'xml+evoque': 'XML+Evoque'
      'xml+lasso': 'XML+Lasso'
      'xml+mako': 'XML+Mako'
      'xml+myghty': 'XML+Myghty'
      'xml+php': 'XML+PHP'
      'xml+erb': 'XML+Ruby'
      'xml+smarty': 'XML+Smarty'
      'xml+velocity': 'XML+Velocity'
      'xquery': 'XQuery'
      'xslt': 'XSLT'
      'xul+mozpreproc': 'XUL+mozpreproc'
      'xtend': 'Xtend'
      'yaml': 'YAML'
      'yaml+jinja': 'YAML+Jinja'
      'zephir': 'Zephir'
      'aspx-cs': 'aspx-cs'
      'aspx-vb': 'aspx-vb'
      'ahk': 'autohotkey'
      'c-objdump': 'c-objdump'
      'cadl': 'cADL'
      'ca65': 'ca65 assembler'
      'cfs': 'cfstatement'
      'cpp-objdump': 'cpp-objdump'
      'd-objdump': 'd-objdump'
      'dg': 'dg'
      'ec': 'eC'
      'liquid': 'liquid'
      'md': 'markdown'
      'mozhashpreproc': 'mozhashpreproc'
      'mozpercentpreproc': 'mozpercentpreproc'
      'nesc': 'nesC'
      'objdump': 'objdump'
      'objdump-nasm': 'objdump-nasm'
      'rst': 'reStructuredText'
      'registry': 'reg'
      'sqlite3': 'sqlite3con'
      'systemverilog': 'systemverilog'
      'verilog': 'verilog'
      'vhdl': 'vhdl'
    }
    @CODE_THEME = {
      'fruity': 'fruity'
      'monokai': 'monokai'
      'solarized': 'solarized'
      'xcode': 'xcode'
      'tango': 'tango'
      'vim': 'vim'
      'vs': 'vs'
      'igor': 'igor'
      'solarized256': 'solarized256'
      'lovelace': 'lovelace'
      'autumn': 'autumn'
      'perldoc': 'perldoc'
      'borland': 'borland'
      'emacs': 'emacs'
      'friendly': 'friendly'
      'murphy': 'murphy'
      'bw': 'bw'
      'trac': 'trac'
      'algol': 'algol'
      'paraiso-dark': 'paraiso-dark'
      'paraiso-light': 'paraiso-light'
    }
    @initialCodeBlock()
    @initial()
    @bind()

  initial: ->
    $('#submit-form #content').val ''
    $('#submit-form #code').val ''
    $('#submit-form #hashtag').val ''
    $('#submit-form #reply_to').val ''
    $('#submit-form #type option[value="text"]').prop('selected', true)

  bind: ->
    @checkEmbedForm()
    bind '#submit-form #type', 'change', ( (event) => @handleTypeChange(event) )
    bind '#kxgio-app', 'change', ( (event) => @handleKxgioAppChange(event) )
    bind '#button-submit', 'click', @handleFormSubmit
    bind '#button-reauth', 'click', @handleUserReauth
    bind '.kxgio-form-data:first', 'blur change keyup', @bindKxgioAppContent, '.kxgio-embed-form'

  initialCodeBlock: =>
    FormView.main.language @CODE_LANG
    FormView.main.theme @CODE_THEME

  handleFormSubmit: =>
    return false if !User.hasToken()
    return false if User.me is undefined
    if @checkLicenseCheckbox() is false
      alert MESSAGE.asshole_read_the_license
      return false
    @handleFormData()

  handleFormData: =>
    @data.type = $('#type').val()
    @data.content = $('#content').val()
    @data.hashtag = $('#hashtag').val()
    @data.reply_to = $('#reply_to').val()
    @data.identification = User.identification
    if @data.type isnt 'image' and @data.content is ''
      alert MESSAGE.content_is_empty
      $('#content').focus()
      return false
    if @data.type is 'code'
      if $('#code').val() isnt ''
        @data.code = $('#code').val()
      else
        alert MESSAGE.code_is_empty
        return false
    @handlePublishView 'on'
    if @data.type is 'image'
      @handleImageModeContent()
    else if @data.type is 'code'
      @handleCodeImage()
    else
      @submitForm()

  handleCodeImage: =>
    data =
      'code': $('#code').val()
      'language': $('#code_language').val()
      'theme': $('#code_theme').val()
    post API_URL + 'create/code-image', ((response) ->
      if response.success
        @handleImgurUpload response.image
      else
        alert MESSAGE.post_submit_failed
    ).bind(@), data, true

  handleImgurUpload: (image) =>
    postImgur ((response) ->
      @data.image_url = response.data.link
      @submitForm()
    ).bind(@), { image: image }

  submitForm: =>
    post API_URL + 'create', ((response) ->
      if response.success
        redirect '/post/?key=' + response.data.key
      else
        alert MESSAGE.post_submit_failed
        @handlePublishView 'off'
    ).bind(@), @data, true

  checkLicenseCheckbox: ->
    return if $('#accept-license').prop('checked') and $('#accept-license-check').prop('checked') then true else false

  handleImageModeContent: (data) =>
    app_key = $('#kxgio-app').val()
    app = 'KxgioApp_' + app_key
    @data.image_config = JSON.stringify(window[app].getFormData())
    @createImageUrlInput()
    window[app].getImgurImage (action, data, response) ->
      $('#image_url').val response.data.link

  createImageUrlInput: =>
    $('<input>').attr(
      type: 'hidden'
      id: 'image_url'
      value: '').appendTo 'body'
    @checkImageUrlInput()

  checkImageUrlInput: =>
    imageUrlInputInterval = setInterval(( ->
      if $('#image_url').val() isnt ''
        @data.image_url = $('#image_url').val()
        @submitForm()
        clearInterval imageUrlInputInterval
    ).bind(@), 100)

  checkEmbedForm: ->
    embedFormCheckInterval = setInterval(->
      if KXGIO_APPS.map((x) -> $('#kxgio-embed-'+x).length).reduce(((a, b) -> a + b), 0) is KXGIO_APPS.length
        $('body').find('.kxgio-form-preview img').addClass 'img-responsive'
        clearInterval embedFormCheckInterval
    , 100)

  handleTypeChange: (event) ->
    value = event.target.value
    if value == 'image'
      $('#image-config-block').show()
      $('#content-block').hide()
      $('#code-block').hide()
    else if value == 'code'
      $('#image-config-block').hide()
      $('#content-block').show()
      $('#code-block').show()
    else
      $('#image-config-block').hide()
      $('#content-block').show()
      $('#code-block').hide()

  handleKxgioAppChange: (event) ->
    value = event.target.value
    $('.kxgio-embed-form').removeClass 'on'
    $('#kxgio-embed-' + value).addClass 'on'

  bindKxgioAppContent: (event) ->
    $('#content').val event.target.value

  handlePublishView: (value) ->
    if value is 'on'
      $('body').addClass 'publishing'
    else
      $('body').removeClass 'publishing'

  handleUserReauth: ->
    redirect AUTH_URL + User.me.provider

Form = new Form
module.exports = Form
