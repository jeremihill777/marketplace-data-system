const express = require("express");
const app = express();

app.use(express.json());


app.get("/", (req, res) => {
  res.send("Marketplace API run!");
});


const PORT = 5000;
app.listen(PORT, () => {
  console.log(`server run ${PORT}`);
});
