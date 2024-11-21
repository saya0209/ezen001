package org.zerock.util.vo;

import lombok.Data;

@Data
public class WeatherVO {

	private String forecastDate;
	private String forecastTime;
	private String forecastWeather;  // 날씨
	private String forecastTemperature; // 습도
	private String forecastHumidity;  // 지역
	private String forecastRegion;
	
}
