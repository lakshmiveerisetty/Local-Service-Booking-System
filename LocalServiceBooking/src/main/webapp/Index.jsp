<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html><html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Local Service Booking System</title><style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    background: #f5f7fb;
    color: #1e293b;
}

nav {
    background: #123b67;
    color: white;
    padding: 18px 7%;
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-wrap: wrap;
    gap: 15px;
}

.logo {
    font-size: 23px;
    font-weight: bold;
}

nav a {
    color: white;
    text-decoration: none;
    margin-left: 22px;
    font-size: 15px;
}

nav a:hover {
    color: #fbbf24;
}

.hero {
    text-align: center;
    padding: 75px 20px;
    background: linear-gradient(135deg, #e0f2fe, #eff6ff);
}

.hero h1 {
    font-size: 38px;
    color: #123b67;
    margin-bottom: 18px;
}

.hero p {
    font-size: 17px;
    color: #475569;
    margin-bottom: 28px;
    line-height: 1.7;
}

.btn {
    display: inline-block;
    padding: 12px 25px;
    margin: 6px;
    border-radius: 6px;
    text-decoration: none;
    font-weight: bold;
}

.primary {
    background: #2563eb;
    color: white;
}

.secondary {
    background: white;
    color: #123b67;
    border: 1px solid #123b67;
}

.btn:hover {
    opacity: 0.85;
}

.services {
    padding: 45px 7%;
    text-align: center;
}

.services h2 {
    color: #123b67;
    font-size: 29px;
    margin-bottom: 12px;
}

.subtitle {
    color: #64748b;
    margin-bottom: 30px;
}

.service-container {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
    gap: 20px;
}

.card {
    background: white;
    padding: 28px 18px;
    border-radius: 10px;
    box-shadow: 0 3px 12px rgba(0,0,0,0.07);
    transition: transform 0.2s;
}

.card:hover {
    transform: translateY(-5px);
}

.card .emoji {
    font-size: 38px;
    margin-bottom: 15px;
}

.card h3 {
    color: #123b67;
    margin-bottom: 10px;
}

.card p {
    color: #64748b;
    font-size: 14px;
    line-height: 1.5;
}

footer {
    background: #123b67;
    color: white;
    text-align: center;
    padding: 20px;
    margin-top: 25px;
}

@media (max-width: 600px) {
    nav {
        justify-content: center;
        text-align: center;
    }

    nav a {
        margin: 6px;
    }

    .hero h1 {
        font-size: 29px;
    }
}
</style></head><body><nav>
    <div class="logo">Local Service Booking</div><div>
    <a href="Index.jsp">Home</a>
    <a href="#services">Services</a>
    <a href="Login.jsp">Login</a>
    <a href="Register.jsp">Register</a>
</div>

</nav><section class="hero">
    <h1>Your Home, Our Responsibility!</h1><p>
    Find trusted professionals for all your home service needs.<br>
    Easy booking, reliable service, and convenient solutions.
</p>

<a href="Login.jsp" class="btn primary">Book a Service</a>
<a href="Register.jsp" class="btn secondary">Create Account</a>

</section><section class="services" id="services">
    <h2>Our Services</h2>
    <p class="subtitle">
        Professional help for your everyday needs
    </p><div class="service-container">

    <div class="card">
        <div class="emoji">🔧</div>
        <h3>Plumbing</h3>
        <p>Help with taps, pipes, leaks, and repairs.</p>
    </div>

    <div class="card">
        <div class="emoji">💡</div>
        <h3>Electrical Repair</h3>
        <p>Electrical repairs and home wiring services.</p>
    </div>

    <div class="card">
        <div class="emoji">🧹</div>
        <h3>Home Cleaning</h3>
        <p>Keep your home clean and comfortable.</p>
    </div>

    <div class="card">
        <div class="emoji">🪚</div>
        <h3>Carpenter</h3>
        <p>Furniture repairs and woodwork assistance.</p>
    </div>

    <div class="card">
        <div class="emoji">❄️</div>
        <h3>AC Repair</h3>
        <p>Air conditioner servicing and maintenance.</p>
    </div>

</div>

</section><footer>
    <p>© 2026 Local Service Booking System | All Rights Reserved</p>
</footer></body>
</html>