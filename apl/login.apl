#include "protheus.ch"
#include "apwebex.ch"
#include "tbiconn.ch"

// Monta form de login                         
user function portal1(bErro)
  local cHtml := ''
  private bExibirMensagem := .f.

  if bErro
    bExibirMensagem := .t.
  endif
  cHtml := h_form()
return cHtml       

// Autentica form de login
user function portal2()
  local cHtml := ''
  local cUsuario := HttpPost->usuario
  local _cSenha := HttpPost->senha
  
  if cUsuario == 'paulo' .and. _cSenha == '1234'
    cHtml := u_portal3()
  else
    cHtml := u_portal1(.t.)
  endif
return cHtml       

// Monta tela pós login
user function portal3()
  local cHtml := 'Logado!' 
return cHtml       





