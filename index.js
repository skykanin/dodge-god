var express = require('express');
var app = express();
var fs = require('fs')

let scores = {}
fs.readFile("./scores.json",null,function(err,data){
	if(err) return console.log("kys"); 
	console.log(data)
	scores=JSON.parse(data)
})

app.get('/', function(req,res){
	if("time" in req.query && "name" in req.query){
		name=req.query.name
		time=Number(req.query.time)
		prevTime= name in scores ? scores[name][0] : 0;
		if (time > prevTime || !prevTime) {
			let d=new Date().toDateString().split(" ")
			scores[name] = [time,`${d[2]}.${d[1]}.${d[3]}`]
			fs.writeFile("./scores.json",JSON.stringify(scores),function(err){
				if (err) console.log(err)
			})
		}
	}

	res.send(sortScore())
})
app.get('/scores', function(req,res){
	res.send(sortScore())
})
function sortScore(){
	return Object.entries(scores).sort((a,b)=>b[1][0]-a[1][0])
}
app.listen(3000);
console.log("listening on port 3000")
