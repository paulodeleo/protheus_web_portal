#include "protheus.ch"
#include "apwebex.ch"
#include "tbiconn.ch"
                         
// Função de roteamento, a única que deverá ser chamada no navegador.
// Seu parametros, como modulo e acao, é que chamarão as funções
// Chamar no browser como http://localhost:8080/u_index.apw
user function index()

	local cHtml
	WEB EXTENDED INIT cHtml

	cHtml := h_cabecalho()

  HttpHeadOut->content_type := "text/html; charset=ISO-8859-1" // força encoding e corrige problemas com acentos

	if HttpGet->modulo == 'login'
		if HttpGet->acao == nil .or. HttpGet->acao == 'form'
		  cHtml += u_portal1()
	 	elseif HttpGet->acao == 'autenticacao'
	 		cHtml += u_portal2()
	 	elseif HttpGet->acao == 'sair'
	 		cHtml += u_portal5()
	 	endif
	elseif HttpGet->modulo == 'compras'
		if HttpGet->acao == nil .or. HttpGet->acao == 'listagem_sc'
	 		cHtml += u_portal3()
	 	elseif HttpGet->acao == 'cotacoes'
	 		cHtml += 'Tela de tesde de compras - cotacoes'
	 	elseif HttpGet->acao == 'pedidos'
	 		cHtml += 'Tela de tesde de compras - pedidos'
	 	endif
	elseif HttpGet->modulo == 'faturamento'
	 	cHtml += 'Tela de teste faturamento'
	elseif HttpGet->modulo == 'rh'
	 	cHtml += 'Tela de teste RH'
	else
		cHtml += u_portal1()
	endif

	cHtml += h_rodape()

	WEB EXTENDED END

return cHtml       
