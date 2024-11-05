package org.zerock.util.vo;

import lombok.Data;

@Data
public class WeatherVO {

	private String forecastDate;
	private String forecastTime;
	private String forecastWeather;
	private String forecastTemperature;
	private String forecastHumidity;
	private String forecastRegion;
}
