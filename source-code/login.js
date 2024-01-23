document.addEventListener("DOMContentLoaded", function() {
    document.getElementById("login-form").addEventListener("submit", function(e) {
        e.preventDefault(); 
        // This entire code sends AJAX request to validate id and password, and displays error message based on the response.

        var userID = document.getElementById("id").value;
        var userPassword = document.getElementById("password").value;

        var xhr = new XMLHttpRequest();
        xhr.open("POST", "loginCheck.jsp", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhr.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
                var response = JSON.parse(this.responseText);
                var messageDiv = document.getElementById("loginMessage");
                if (response.isAuthenticated) {
                    document.getElementById("login-form").submit();
                } else {
                    messageDiv.style.display = "block";
                    messageDiv.textContent = "  Invalid ID or password. Please try again.";
                }
            }
        };
        xhr.send("id=" + userID + "&password=" + userPassword);
    });
});
