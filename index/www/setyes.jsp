<%@page import="trashcar.bean.TrashCarRecordBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" import="java.util.*,trashcar.bean.TrashCarRecordBean,trashcar.bean.TrashCarBean"%>
<!DOCTYPE html>
<html lang="zh-TW">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="/scss/set.css">
    <link rel="stylesheet" media="screen and  (max-width: 780px)" href="/scss/set780.css" />
    <title>設定</title>
    <style>

    </style>
</head>

<body>
    <div id="div1">
        <h1>設定</h1>
        <form class="form1" method="post" action="/ican/GetCarsToDB">
            <fieldset>
                <legend>GPS</legend>
                
                 
      
                <label for="GPS"></label>
                <input type="button" onclick="getLocation()" value="查詢當前位置" >
                <span id="showPosition"></span><br>
                <iframe id="gmframe" width="360" height="240" frameborder="0" scrolling="no" marginheight="0"
                    marginwidth="0" src="https://maps.google.com/?output=embed&amp;q=25.033934,121.543409"></iframe><br>
                    <br>
                <label for="gt">垃圾車選擇:</label><br>
                <input type="radio" id="gt1" name="gt" value="1">
                <label for="male">gt1</label>
                <iframe id="gt1frame" width="360" height="240" frameborder="0" scrolling="no" marginheight="0"
                    marginwidth="0" src="https://maps.google.com/?output=embed&amp;q=25.033934,121.543409"></iframe>
                     
                <input type="radio" id="gt2" name="gt" value="2">
                <label for="female">gt2</label>
                <iframe id="gt2frame" width="360" height="240" frameborder="0" scrolling="no" marginheight="0"
                    marginwidth="0" src="https://maps.google.com/?output=embed&amp;q=25.033934,121.543409"></iframe>
                <input type="radio" id="gt3" name="gt" value="3">
                <label for="other">gt3</label>
                <iframe id="gt3frame" width="360" height="240" frameborder="0" scrolling="no" marginheight="0"
                    marginwidth="0" src="https://maps.google.com/?output=embed&amp;q=25.033934,121.543409"></iframe>
 				<input type="submit"  value="設定完成">           
            </fieldset>
            <input type="hidden" name="lat" id="lat">
            <input type="hidden" name="lng" id="lng"> 
            
            
        </form>
        <a href="/index.html"><button>回首頁</button></a><br>
    </div>


    <script>
    	var datas=null;   	
        var map, marker, lat, lng;
        function getLocation() {//取得 經緯度
            if (navigator.geolocation) {//
                navigator.geolocation.getCurrentPosition(showPosition);//有拿到位置就呼叫 showPosition 函式
            } else {
                document.getElementById("showPosition").innerHTML = "您的瀏覽器不支援 顯示地理位置 API ，請使用其它瀏覽器開啟 這個網址";
            }
        }

        function showPosition(position) {
            document.getElementById("showPosition").innerHTML="成功"
            // document.getElementById("showPosition").innerHTML=" 緯度 (Latitude): 25.033934 經度(Longitude): 121.543409" ;

            // document.getElementById("showPosition").innerHTML = " 緯度 (Latitude): " + position.coords.latitude +
            //     "經度(Longitude): " + position.coords.longitude;
            console.log(" 緯度 (Latitude): " + position.coords.latitude +
                "經度(Longitude): " + position.coords.longitude);
            document.getElementById("gmframe").src = "https://maps.google.com/?output=embed&q=" +  position.coords.latitude + "," + position.coords.longitude;
            //const result = document.querySelector('');
    	        lat=document.getElementById("lat");
    	        lat.value=position.coords.latitude;
              	console.log(lat);
    	        console.log("input: ",lat)
    	        lng=document.getElementById("lng");
    	        lng.value=position.coords.longitude;
              	console.log(lng);
    	        console.log("input: ",lng);
            req = '/ican/GetAllTrashCar?lat=' + position.coords.latitude + "&lng=" + position.coords.longitude;
			
            console.log(req);
            		
            fetch(req, {})
              .then((res) => {
                console.log(res);
                return res.json(); 
              }).then((data) => {
              	console.log("In fetch: " + data);
              	datas=data;
              	document.querySelector("#gt1frame").src = "https://maps.google.com/?output=embed&q=" + data[0]['Lat']  + "," +data[0]['Lng'] ;
              	document.querySelector("#gt2frame").src = "https://maps.google.com/?output=embed&q=" + data[1]['Lat']  + "," +data[1]['Lng'] ;
              	document.querySelector("#gt3frame").src = "https://maps.google.com/?output=embed&q=" + data[2]['Lat']  + "," +data[2]['Lng'] ;
				form = document.querySelector("form");
              	for (n in datas){
              		for (par in datas[n]){
              			par_name = par + "" + (Number(n)+1)
              			input = document.getElementsByName(par_name)
              			if (input.length == 0) {
              				input = document.createElement("input")
              				input.name = par_name;
              				input.type = "hidden"
              			}
              			input.value = datas[n][par]
              			console.log("input:", input);
              			form.appendChild(input)
              		}
              	}
              	console.log("form:", form)
              }).catch((err) => {
                console.log('錯誤:', err);
            });
            console.log("Out fetch: " + datas);
        }
       	function getradio(){
       		if(document.querySelector('input[name="gt"]:checked')==null)
       			console.log("error")
       		else
       			console.log("success")
    		
       	}
        
        
    </script>
</body>

</html>