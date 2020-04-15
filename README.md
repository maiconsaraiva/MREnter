# MREnter - Sobre
O Componente MREnter (TMREnter) foi desenvolvido originalmente para facilitar a passagem de um programa DOS para um novo aplicaitivo baseado na plataforma Windows. Normalmente, nesta passagem, o fato de ter de passar de um campo para outro utilizando a tecla TAB deixa o operador um pouco deslocado.

TMREnter captura o evento padrão OnMessage de TApplication e faz com que o processamento da tecla ENTER seja trocado para o processamento da tecla TAB, o Windows assim responde corretamente ao evento.
Apenas um TMREnter deve ser utilizado por aplicação e posicionado no form principal.

# Instalação
1. Abra o Delphi, adicione o a pasta MREnter ao Library Path x32
2. Abra o MREnter.dpk;
3. Clique com o botão direito em MREnter.bpl e clique em Compile, depois em Install;
4. Feche tudo sem salvar;
5. Agora basta abrri seu projeto, e no form principal, adicionar o novo componente MREnter, em seguida, configure como desejado;

# Documentação
[!MREnter - Documentacao](MREnter - Documentacao.pdf "MREnter - Documentacao")

# Changelog
[MREnter - Changelog.md](MREnter - Changelog.md)
