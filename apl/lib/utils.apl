#include "protheus.ch"
#include "apwebex.ch"
#include "tbiconn.ch"

// Verifica se um usuário está logado, exceto se o módulo acessado é justamente o de login
// Se o usuário não estiver autenticado, redireciona para a tela de login
user function verifica_login()
  local cHtmlConn := ''
  if !HttpSession->logado .or. HttpSession->logado == nil
    nPosicaoEncontrada := at('/u_index.apw?modulo=login', HttpHeadIn->aHeaders[1])
    if nPosicaoEncontrada == 0 .or. nPosicaoEncontrada > 6 // url de login não foi encontrada ou não está no inicio
      cHtmlConn := redirpage('/u_index.apw?modulo=login')
    endif
  endif
return cHtmlConn