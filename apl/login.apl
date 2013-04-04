#include "protheus.ch"
#include "apwebex.ch"
#include "tbiconn.ch"

// Monta form de login
// Se lErro for verdadeiro, mensagem de erro será exibida
user function portal1(lErro)
  local cHtml := ''
  private lExibirMensagem := .f.

  if lErro
    lExibirMensagem := .t.
  endif
  cHtml := h_form()
return cHtml       

// Autentica form de login
user function portal2()

  local cHtml := ''
  local _cUsuario := HttpPost->usuario
  local _cSenha := HttpPost->senha

  PswOrder(2)
  if PswSeek( _cUsuario, .t. ) .and. PswName(_cSenha) .and. !empty(_cUsuario + _cSenha)
    cHtml := u_portal3()
  else
    cHtml := u_portal1(.t.)
  endif

return cHtml       

// Monta tela pós login
user function portal3()
  local cHtml := 'Logado!' 
return cHtml       





