document.addEventListener("DOMContentLoaded", function() {
    document.getElementById("signup-form").addEventListener("submit", function(e) {
        e.preventDefault(); 
     // Get user input values from the form
        var userID = document.getElementById("id").value;
        var userNickname = document.getElementById("nickname").value;
        var userPhone = document.getElementById("phone").value;
        var password = document.getElementById("password").value;
        var confirmPassword = document.getElementById("confirm-password").value;
     // Check if the entered passwords match
        if(password !== confirmPassword) {
            var messageDiv = document.getElementById("duplicateMessage");
            messageDiv.style.display = "block";
            messageDiv.textContent = "Passwords do not match. Please try again.";
            return;
        }
    // AJAX request setup
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "checkDuplicate.jsp", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
     // Define what happens on state change of the AJAX request
        xhr.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
                var response = JSON.parse(this.responseText);
                var messageDiv = document.getElementById("duplicateMessage");
                // Check if the userID is already taken
                if (response.idDuplicate) {
                    messageDiv.style.display = "block";
                    messageDiv.textContent = "ID already exists. Please try again.";
                } else if (response.nicknameDuplicate) {// Check if the nickname is already taken
                    messageDiv.style.display = "block";
                    messageDiv.textContent = "Nickname already exists. Please try again.";
                } else if (response.phoneDuplicate) {// Check if the phone number is already taken
                    messageDiv.style.display = "block";
                    messageDiv.textContent = "Phone number already exists. Please try again.";
                } else {// If no duplicates, submit the form
                    messageDiv.style.display = "none";
                    document.getElementById("signup-form").submit();
                }
            }
        };
        xhr.send("id=" + userID + "&nickname=" + userNickname + "&phone=" + userPhone);
    });
});
