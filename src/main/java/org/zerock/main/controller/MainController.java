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
	    
	    String[] wData = new String[5];  // 날씨 정보 배열
	    String err = WeatherXML.getWeatherXML(56, 128, wData);  // 날씨 정보 가져오기
	    WeatherVO weatherVO = null;

	    if (err == null) {  // 오류가 없으면
	        if (wData != null && wData.length >= 5) {  // wData 배열이 올바르게 채워졌는지 확인
	            log.info("날짜 : " + wData[0]);
	            log.info("시간 : " + wData[1]);
	            log.info("날씨 : " + wData[2]);
	            log.info("기온 : " + wData[3]);
	            log.info("습도 : " + wData[4]);

	            weatherVO = new WeatherVO();
	            weatherVO.setForecastRegion("마두2동");
	            weatherVO.setForecastDate(wData[0].substring(0, 4) + "-"
	                    + wData[0].substring(4, 6) + "-" 
	                    + wData[0].substring(6));  // 날짜 포맷 변경
	            weatherVO.setForecastTime(wData[1].substring(0, 2)
	                    + ":" + wData[1].substring(2));  // 시간 포맷 변경
	            weatherVO.setForecastWeather(wData[2]);
	            weatherVO.setForecastHumidity(wData[4]);
	        } else {
	            log.error("날씨 정보가 올바르게 수집되지 않았습니다.");
	        }
	    } else {
	        log.error("날씨 정보를 가져오는 데 실패했습니다. 오류 메시지: " + err);
	    }

	    model.addAttribute("weatherVO", weatherVO);  // 모델에 데이터 추가

	    return "main/main";  // 뷰 이름 반환
	}
}








