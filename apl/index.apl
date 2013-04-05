#include "protheus.ch"
#include "apwebex.ch"
#include "tbiconn.ch"
                         
// Função de roteamento, a única que deverá ser chamada no navegador.
// Seu parametros, como modulo e acao, é que chamarão as funções
// Chamar no browser como http://localhost:8080/u_index.apw
user function index()

	local cHtml := '' 
	WEB EXTENDED INIT cHtml

	if HttpSession->logado == nil
		HttpSession->logado == .f.
	endif

  HttpHeadOut->content_type := "text/html; charset=ISO-8859-1" // força encoding e corrige problemas com acentos

	if HttpGet->modulo == 'login'
		if HttpGet->acao == nil .or. HttpGet->acao == 'form'
		  cHtml := u_portal1()
	 	elseif HttpGet->acao == 'autenticacao'
	 		cHtml := u_portal2()
	 	endif
	elseif HttpGet->modulo == 'compras'
		if HttpGet->acao == nil .or. HttpGet->acao == 'listagem_sc'
	 		cHtml := u_portal3()
	 	endif
	else
		cHtml := u_portal1()
	endif

	WEB EXTENDED END

return cHtml       
