## MREnter - Sobre
O Componente MREnter (TMREnter) foi desenvolvido originalmente para facilitar a passagem de um programa DOS para um novo aplicaitivo baseado na plataforma Windows. Normalmente, nesta passagem, o fato de ter de passar de um campo para outro utilizando a tecla TAB deixa o operador um pouco deslocado.

TMREnter captura o evento padrão OnMessage de TApplication e faz com que o processamento da tecla ENTER seja trocado para o processamento da tecla TAB, o Windows assim responde corretamente ao evento.
Apenas um TMREnter deve ser utilizado por aplicação e posicionado no form principal.

## Instalação
1. Abra o Delphi, adicione o a pasta MREnter ao Library Path x32
2. Abra o MREnter.dpk;
3. Clique com o botão direito em MREnter.bpl e clique em Compile, depois em Install;
4. Feche tudo sem salvar;
5. Agora basta abrri seu projeto, e no form principal, adicionar o novo componente MREnter, em seguida, configure como desejado;

## Documentação
[Doc/MREnter-Documentacao.pdf](../../raw/Doc/MREnter-Documentacao.pdf)
(recomendo que faça o download e abra em um leitor como o AdobeReader para poder navegar entre os tópicos)

## Changelog (Histórico de alterações)
[Doc/MREnter-Changelog.md](Doc/MREnter-Changelog.md)

## ToDo
- Falta criar tratamento (ou extensão do componente) para compatibilizar com os componentes da DevExpress.
Eles não são capturados pelo ActiveControl como os demais, por isso precisam de um tratamento especial.
Mais detalhes nos Links abaixo:
 - https://supportcenter.devexpress.com/Ticket/Details/Q271132/how-to-get-real-activecontrol
 - https://supportcenter.devexpress.com/ticket/details/a1102/how-to-obtain-the-cx-editor-corresponding-to-the-activecontrol-property
