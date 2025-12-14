// -------------------------------
// Load currency list dynamically
// -------------------------------

const currencyList = [
    "EUR", "USD", "GBP", "JPY", "CHF", "SEK", "NOK", "DKK",
    "TRY", "AED", "AUD", "CAD", "CNY", "INR", "KRW", "ZAR"
];

const fromSelect = document.getElementById("fromCurrency");
const toSelect = document.getElementById("toCurrency");

currencyList.forEach(cur => {
    let opt1 = document.createElement("option");
    let opt2 = document.createElement("option");
    opt1.value = opt1.text = cur;
    opt2.value = opt2.text = cur;
    fromSelect.appendChild(opt1);
    toSelect.appendChild(opt2);
});

fromSelect.value = "EUR";
toSelect.value = "USD";


// -------------------------------
// Convert Currency
// -------------------------------

async function convert() {
    const amount = document.getElementById("amount").value;
    const from = fromSelect.value;
    const to = toSelect.value;

    if (!amount) {
        alert("Please enter an amount.");
        return;
    }

    try {
        const res = await fetch(`https://api.exchangerate-api.com/v4/latest/${from}`);
        const data = await res.json();

        const rate = data.rates[to];
        const resultValue = (amount * rate).toFixed(2);

        document.getElementById("result").innerText =
            `${amount} ${from} = ${resultValue} ${to}`;

    } catch (error) {
        document.getElementById("result").innerText =
            "Error fetching exchange rate.";
    }
}


// -------------------------------
// Sentiment Analysis Placeholder
// (Connect to Azure later)
// -------------------------------

async function analyzeSentiment() {
    const text = document.getElementById("sentimentText").value;

        if (!text.trim()) {
        alert("Please enter some text first.");
        return;
    }

    const response = await fetch("/sentiment", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ text })
    });
    const data = await response.json();

    if (data.error) {
        document.getElementById("sentimentResult").innerText =
            "Could not analyze sentiment.";
        return;
    }

    const confidence = (data.scores[data.sentiment] * 100).toFixed(1);
    document.getElementById("sentimentResult").innerText =
        `Sentiment: ${data.sentiment.toUpperCase()} (${confidence}% confidence)`;

    /*
    if (!text) {
        alert("Please write something first.");
        return;
    }

    // Placeholder result (before connecting Azure)
    document.getElementById("sentimentResult").innerText =
        "Sentiment analysis will be connected via Azure soon!";
    */
}
