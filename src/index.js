const express = require("express")
const path = require('path');


const app = express()

 app.use(express.static(path.join(__dirname , '..' , 'public')));



app.get("/",(req, res) => {
    res.status(200).send({
        hello: "world"
    })
})

app.get("/getnames", (req, res) => {
    res.status(200).send({
        names: ["John", "Simeon", "Brookes" ,"Chi"]
    })
})

app.get("/getages", (req, res) => {
    res.status(200).send({
        names: [24, 52, 45 ,53]
    })
})
app.listen(8080, () => {
    console.log('server running on port 8080')
})
