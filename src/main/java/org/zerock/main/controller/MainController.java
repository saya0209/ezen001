package org.zerock.main.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.zerock.util.vo.WeatherVO;
import org.zerock.util.weather.WeatherXML;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class MainController {

	@GetMapping(value = {"/", "/main.do"})
	public String goMain() {
		log.info("redirect main---------------");
		return "redirect:/main/main.do";
	}
	
	@GetMapping("/main/main.do")
	public String main(Model model) {
		log.info("/main/main.do =================");
		
		String[] wData = new String[5];
		String err = WeatherXML.getWeatherXML(56, 128, wData);
		WeatherVO weatherVO = null;
		
		if(err == null) {
			// 날씨정보를 가져왔으면 이곳에서 처리 
			log.info("날짜 : "+ wData[0]);
			log.info("시간 : "+ wData[1]);
			log.info("날씨 : "+ wData[2]);
			log.info("기온 : "+ wData[3]);
			log.info("습도 : "+ wData[4]);
			weatherVO = new WeatherVO();
			weatherVO.setForecastRegion("마두2동");
			weatherVO.setForecastDate(wData[0].substring(0,4)+"-"
					+wData[0].substring(4,6) + "-"
					+wData[0].substring(6));
			weatherVO.setForecastTime(wData[1].substring(0,2)
					+":"+wData[1].substring(2));
			weatherVO.setForecastWeather(wData[2]);
			weatherVO.setForecastTemperature(wData[3]);
			weatherVO.setForecastHumidity(wData[4]);
			
		}
		else {
			log.error(err);
		}
		
		model.addAttribute("weatherVO", weatherVO);
		
		return "main/main";
	}
}
