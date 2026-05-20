*** Settings ***
Library    Browser
Library    FakerLibrary

*** Variables ***
${BROWSER}            chromium
${HEADLESS}           ${False}
${SITE_SERVE_REST}    https://front.serverest.dev/

*** Keywords ***
Abrir o navegador
    New Browser    browser=${BROWSER}
    ...            headless=${HEADLESS}
    
    New Context    viewport={'width': 1920, 'height': 1080}
    

Ir para o site Serve Rest Front
    New Page       ${SITE_SERVE_REST}
    ${title}       Get Title    ==    Front - ServeRest
    Log    ${title}

Preencher os dados do novo usuário e cadastrar
    #Exemplos de estratégias
    # Click    css=.btn-link
    # Click    text="Cadastre-se"
    Click       css=a[data-testid='cadastrar']  # usando css pegando um atributo => melhor estratégia
    ${EMAIL}    FakerLibrary.Email
    Fill Text         css=input[data-testid='nome']       Paulo Henrique
    Fill Text         css=input[data-testid='email']      ${EMAIL}
    Fill Text         css=input[data-testid='password']   123456
    Check Checkbox    css=input[data-testid='checkbox']
    Click             css=button[data-testid='cadastrar']

    # seletor em cascata:
    # Click    xpath=//*[@id="root"]//button >> text="Cadastrar"
    
Conferir usuário cadastrado com sucesso
    Wait For Elements State    h1    visible
    Get Text    h1    ==    Bem Vindo Paulo Henrique
    Get Element States    css=button[data-testid='logout']    validate    value & visible