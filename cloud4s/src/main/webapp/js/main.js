
$(document).ready( function(){    
    $('#keyLength').val(512);
    var privateKey;
    var publicKey;
    var ciphertext;
    var cipherpassword;
    // generate new RSA keys
    $('#rsakeyGen').click(function () {
        var sKeySize = $('#keyLength').val();
        var keySize = parseInt(sKeySize);
        var PassPhrase = "The Moon is a Harsh Mistress.";

        privateKey = cryptico.generateRSAKey(PassPhrase, keySize);
        publicKey = cryptico.publicKeyString(privateKey);
        $('#privateKey').val(privateKey);
        $('#publicKey').val(publicKey);
        $('#publicKeyInput').val(publicKey);
        $('#privateKeyInput').val(privateKey);

    });

    // encrypt  password(rsa)
    $('#encrypt').click(function () {
       
        var pswd = $('#password-encrpt').val();

        if (pswd) {
            if (publicKey) {
               
                cipherpassword = cryptico.encrypt(pswd, publicKey);
                $('#pswdCipher').val(cipherpassword);
              
            }
            else {
                alert("No public key found!");
            }

        }
        else {
            alert("Message and Password cannot be empty!");
        }

    });

    //send massage cipher and password cipher to user
    $('#send').click(function () {
        $('#pswdCipher2').val(cipherpassword);       
    });

    //decrypt password(rsa)
    $('#pswdDecrypt').click(function () {
        if ($('#pswdCipher2').val() && $('#privateKeyInput').val()) {
            var password = cryptico.decrypt(cipherpassword.cipher, privateKey);
            $('#password-decrypt').val(password.plaintext);
        }
        else {
            alert("No password cipher found!");
        }
    });

   
});
