package org.zerock.main.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.zerock.goods.service.GoodsService;
import org.zerock.goods.vo.GoodsVO;


import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class MainController {

	@Autowired
	 @Qualifier("goodsServiceImpl")
    private GoodsService goodsService;

    // 카테고리별 상품 조회 (JSON 응답)
	@GetMapping("/getGoodsByCategory")
	@ResponseBody
	public Map<String, Object> getGoodsByCategory(@RequestParam("category") String category) {
	    log.info("getGoodsByCategory()++");

	    Map<String, Object> response = new HashMap<>();
	    try {
	        List<GoodsVO> goodsList = goodsService.getGoodsByCategory(category);

	        // 정상적으로 데이터를 조회한 경우
	        response.put("status", "success");
	        response.put("message", "상품 목록 조회 성공");
	        response.put("category", category);
	        response.put("goods", goodsList);

	    } catch (Exception e) {
	        // 예외 발생 시, 에러 메시지와 함께 응답
	        response.put("status", "error");
	        response.put("message", "상품 목록 조회 중 오류 발생");
	        response.put("errorDetails", e.getMessage());
	    }
	    return response; // 자동으로 JSON 형식으로 변환되어 반환됩니다.
	}


	
	@GetMapping(value = {"/", "/main.do"})
	public String goMain() {
		log.info("redirect main---------------");
		return "redirect:/main/main.do";
	}
	
	@GetMapping("/main/main.do")
	public String main(Model model) {
	    log.info("/main/main.do =================");
	    
//	    String[] wData = new String[5];  // 날씨 정보 배열
//	    String err = WeatherXML.getWeatherXML(56, 128, wData);  // 날씨 정보 가져오기
//	    WeatherVO weatherVO = null;

//	    if (err == null) {  // 오류가 없으면
//	        if (wData != null && wData.length >= 5) {  // wData 배열이 올바르게 채워졌는지 확인
//	            log.info("날짜 : " + wData[0]);
//	            log.info("시간 : " + wData[1]);
//	            log.info("날씨 : " + wData[2]);
//	            log.info("기온 : " + wData[3]);
//	            log.info("습도 : " + wData[4]);
//
//	            weatherVO = new WeatherVO();
//	            weatherVO.setForecastRegion("마두2동");
//	            weatherVO.setForecastDate(wData[0].substring(0, 4) + "-"
//	                    + wData[0].substring(4, 6) + "-" 
//	                    + wData[0].substring(6));  // 날짜 포맷 변경
//	            weatherVO.setForecastTime(wData[1].substring(0, 2)
//	                    + ":" + wData[1].substring(2));  // 시간 포맷 변경
//	            weatherVO.setForecastWeather(wData[2]);
//	            weatherVO.setForecastHumidity(wData[4]);
//	        } else {
//	            log.error("날씨 정보가 올바르게 수집되지 않았습니다.");
//	        }
//	    } else {
//	        log.error("날씨 정보를 가져오는 데 실패했습니다. 오류 메시지: " + err);
//	    }
//
//	    model.addAttribute("weatherVO", weatherVO);  // 모델에 데이터 추가

	    return "main/main";  // 뷰 이름 반환
	}
}








