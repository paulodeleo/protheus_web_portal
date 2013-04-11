#include "protheus.ch"
#include 'topconn.ch'
#include "apwebex.ch"

// Classe para centralizar funções de solicitação de compras
Class SC
  Data cNum
  Method New() Constructor
  Method Status()
EndClass

METHOD New(cNum) CLASS SC
  ::cNum := cNum
Return SELF

// Retorna o status da SC
METHOD Status() CLASS SC
  local nStatus

  If SC1->C1_FLAGGCT=="1"
    nStatus := 1 //'BR_MARROM - Totalmente Atendida'
  elseif SC1->C1_TIPO == 2
    nStatus := 2 //'BR_BRANCO - Solicitacao de Importacao'
  elseif !Empty(SC1->C1_RESIDUO)
    nStatus := 3 //'BR_PRETO - Eliminada por Residuo'
  elseif SC1->C1_QUJE==0.And.SC1->C1_COTACAO==Space(Len(SC1->C1_COTACAO)).And.SC1->C1_APROV$" ,L"
    nStatus := 4 //'ENABLE - Em Aberto'
  elseif SC1->C1_QUJE==0.And.SC1->C1_COTACAO==Space(Len(SC1->C1_COTACAO)).And.SC1->C1_APROV="R"
    nStatus := 5 //'BR_LARANJA - Rejeitada'
  elseif SC1->C1_QUJE==0.And.SC1->C1_COTACAO==Space(Len(SC1->C1_COTACAO)).And.SC1->C1_APROV="B"
    nStatus := 6 //'BR_CINZA - Bloqueada'
  elseif SC1->C1_QUJE==SC1->C1_QUANT'
    nStatus := 7 //'DISABLE - Pedido Colocado'
  elseif SC1->C1_QUJE>0
    nStatus := 8 //'BR_AMARELO - Pedido Colocado Parcial'
  elseif SC1->C1_QUJE==0.And.SC1->C1_COTACAO<>Space(Len(SC1->C1_COTACAO)).And. SC1->C1_IMPORT <>"S" 
    nStatus := 9 //'BR_AZUL - Processo de Cotacao'
  elseif SC1->C1_QUJE==0.And.SC1->C1_COTACAO<>Space(Len(SC1->C1_COTACAO)).And. SC1->C1_IMPORT =="S".And.SC1->C1_APROV$" ,L"
    nStatus := 10 //'BR_PINK - Produto Importado'
  endif

Return nStatus