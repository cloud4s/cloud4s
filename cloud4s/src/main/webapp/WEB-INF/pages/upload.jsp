<header>
    <!--AES sripts-->
    <script src="js/aes/jquery.js"></script>
    <script src="js/aes/aes.js"></script>
    <script src="js/aes/aes-ctr.js"></script>
    <script src="js/aes/aes-ctr-file.js"></script>
    <script src="js/aes/file-saver.js"></script>	
    <script src="js/aes/mtl.js"></script>
    <script src="js/aes/prettify.js"></script>	

    <!--RSA scripts-->
    <script src="js/rsa/aes.js"></script>
    <script src="js/rsa/rsa.js"></script>
    <script src="js/rsa/api.js"></script>
    <script src="js/rsa/cryptico.js"></script>
    <script src="js/rsa/cryptico.min.js"></script>
    <script src="js/rsa/hash.js"></script>
    <script src="js/rsa/jsbn.js"></script>
    <script src="js/rsa/random.js"></script>
    <script src="js/rsa/jsencrypt.js"></script>

    <script src="js/main.js"></script>

    
</header>
<head>
    
    <link rel="stylesheet" type="text/css" href="css/button.css">
    <link rel="stylesheet" type="text/css" href="css/main2.css">
    <title>PGP Demo - CLOUD4s</title>
</head>

<body>
    <label>RSA Key Generation</label>
    <div>
        <span>
            <select id="keyLength">
                <option value="512">512 bit</option>
                <option value="1024">1024 bit</option>
                <option value="2048">2048 bit</option>
                <option value="4096">4096 bit</option>
            </select>
        </span>
        <button id="rsakeyGen" class="button">Generate key</button>
        <br /><br />
        <textarea id="publicKey" placeholder="Public key" readonly></textarea>
        <textarea id="privateKey" placeholder="Private key" readonly></textarea>
        

    </div>
    <br />
    <label>Encryption</label>
    <div>
        <label>Password</label>
        <input name="password-file" id="password-encrpt" value="" type="text">
        <p>Select file to encrypt: </p>
        <input name="src-file" id="src-file" onchange="encryptFile(this.files[0])" type="file">
       
        <br/><br />
        <textarea placeholder="Reciever Public Key" id="publicKeyInput" readonly></textarea>
        <button id="encrypt" class="button">Encrypt Password</button>
        <br /><br /> 
        <textarea placeholder="Password Cipher" id="pswdCipher" readonly></textarea>    
       
            
        <br /><br />
        <button id="send" class="button">Send</button>
    </div>
    <br />
    <label>Decryption</label>
	<div>
        
        
        
        <textarea placeholder="Password Cipher" id="pswdCipher2" readonly></textarea>
        
        <br /><br />
        <textarea placeholder="Reciever Private Key" id="privateKeyInput" readonly></textarea>
        <br /><br/>
        <button id="pswdDecrypt" class="button">Decrypt Passowrd</button>
        <br /><br />
        <input name="password-file" id="password-decrypt" value="" type="text">
        <br />
        <p>Browse encrypted file to decrypt: </p>
        <input name="enc-file" id="enc-file" onchange="decryptFile(this.files[0])" type="file">
        <br /><br />
       
    </div>
    
    


</body>

