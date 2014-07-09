// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= jquery.maskedinput
//= require jquery-1.11.1
//= require_tree .

function buscacep() {
    if ($.trim($("#cep").val()) != "") {
        $("#lcep").html("Pesquisando...") //mostra na viw do form uma menssagem
        $.getScript("http://cep.republicavirtual.com.br/web_cep.php?formato=javascript&cep=" + $("#cep").val(), function() {
            if (resultadoCEP["resultado"] == "1") {
                $("#endereco").val(unescape(resultadoCEP["tipo_logradouro"]) + unescape(resultadoCEP["logradouro"]));
                $("#bairro").val(unescape(resultadoCEP["bairro"]));
                $("#cidade").val(unescape(resultadoCEP["cidade"]));
                $("#estado").val(unescape(resultadoCEP["uf"]));;

                $("#numero").focus();
            } else {
                $("#lcep").html("Cep não encotrado.");
                $("#cep").focus();
            }
            $("#lcep").html(" ")
        });
    } else {
        $("#lcep").html("CEP foi encontrado ");
    }
}

function limpacampos() {
    $("#endereco").val("");
    $("#bairro").val("");
    $("#cidade").val("");
    $("#estado").val("");
    $("#complemento").val("");
}



function validarCPF(cpf) {

    cpf = cpf.replace(/[^\d]+/g, '');
    if (cpf == '') {
        alert("Por favor preencha o campo de CPF");
        return false;
    }
    if (cpf.length != 11 || cpf == "00000000000" || cpf == "11111111111" || cpf == "22222222222" || cpf == "33333333333" || cpf == "44444444444" || cpf == "55555555555" || cpf == "66666666666" || cpf == "77777777777" || cpf == "88888888888" || cpf == "99999999999") {
        alert("O CPF " + cpf + " não é válido");
        return false;
    }
    // Valida 1o digito add = 0;
    var add = 0
    for (i = 0; i < 9; i++)
        add += parseInt(cpf.charAt(i)) * (10 - i);
    rev = 11 - (add % 11);
    if (rev == 10 || rev == 11) rev = 0;
    if (rev != parseInt(cpf.charAt(9))) {
        alert("O CPF " + cpf + " não é válido");
        return false
    }

    // Valida 2o digito add = 0;
    var add = 0
    for (i = 0; i < 10; i++)
        add += parseInt(cpf.charAt(i)) * (11 - i);
    rev = 11 - (add % 11);
    if (rev == 10 || rev == 11) rev = 0;
    if (rev != parseInt(cpf.charAt(10))) {
        alert("O CPF " + cpf + " não é válido");
        return false
    }
    return true;
}

function validarCNPJ(cnpj) {

    cnpj = cnpj.replace(/[^\d]+/g, '');

    if (cnpj == '') {
        alert("O CNPJ deve ser preenchido");
        return false;
    }

    if (cnpj.length != 14) {
        alert("O CNPJ " + cnpj + " não é válido");
        return false;
    }

    // Elimina CNPJs invalidos conhecidos
    if (cnpj == "00000000000000" ||
        cnpj == "11111111111111" ||
        cnpj == "22222222222222" ||
        cnpj == "33333333333333" ||
        cnpj == "44444444444444" ||
        cnpj == "55555555555555" ||
        cnpj == "66666666666666" ||
        cnpj == "77777777777777" ||
        cnpj == "88888888888888" ||
        cnpj == "99999999999999") {
        alert("O CNPJ " + cnpj + " não é válido");
        return false;
    }

    // Valida DVs
    tamanho = cnpj.length - 2
    numeros = cnpj.substring(0, tamanho);
    digitos = cnpj.substring(tamanho);
    soma = 0;
    pos = tamanho - 7;
    for (i = tamanho; i >= 1; i--) {
        soma += numeros.charAt(tamanho - i) * pos--;
        if (pos < 2)
            pos = 9;
    }
    resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
    if (resultado != digitos.charAt(0)) {
        alert("O CNPJ " + cnpj + " não é válido");
        return false;
    }

    tamanho = tamanho + 1;
    numeros = cnpj.substring(0, tamanho);
    soma = 0;
    pos = tamanho - 7;
    for (i = tamanho; i >= 1; i--) {
        soma += numeros.charAt(tamanho - i) * pos--;
        if (pos < 2)
            pos = 9;
    }
    resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
    if (resultado != digitos.charAt(1)) {
        alert("O CNPJ " + cnpj + " não é válido");
        return false;
    }

    return true;

}

