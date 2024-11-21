package org.zerock.util.weather;

import java.net.HttpURLConnection;
import java.net.URL;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

// 기상철 초단기예보를 XML로 요청해서 받아오는 프로그램
// 마두2동, 장항1동, 장항2동 x:56, y:128
// 현재시간이 예) 10시 29분까지 -> 10시예보, 10시 30분부터 -> 11시예보
public class WeatherXML {

	public static String getWeatherXML(int x, int y, String[] v) {
	    HttpURLConnection con = null;
	    String err = null; // Error Message
	    String serviceKey = "MU29%2FXWSIzd2DcAIbhoJU0ZlpS16nyWgDhXGXrKzzI3dQceJpqjLzZwU%2BcGrNEIAAAhi2Hh%2B3BolRMwZ4%2BxPJw%3D%3D";

	    try {
	        LocalDateTime dateTime = LocalDateTime.now().minusMinutes(30); // 현재시간에서 30분 전

	        String urlStr = (""
	        		+ "https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtFcst"
	                + "?serviceKey=" + serviceKey
	                + "&pageNo=1"
	                + "&numOfRows=1000"
	                + "&dataType=XML"
	                + "&base_date=" + dateTime.format(DateTimeFormatter.ofPattern("yyyyMMdd"))
	                + "&base_time=" + dateTime.format(DateTimeFormatter.ofPattern("HHmm"))
	                + "&nx=" + x
	                + "&ny=" + y
	                );

	        // 로그 추가: 요청 URL 출력
	        System.out.println("Request URL: " + urlStr);
	        
	        URL url = new URL(urlStr);
	        con = (HttpURLConnection) url.openConnection();

	        Document doc = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(con.getInputStream());
	        
	        

	        boolean ok = false;
	        Element e;
	        NodeList ns = doc.getElementsByTagName("header");

	        if (ns.getLength() > 0) {
	            e = (Element) ns.item(0);
	            if ("00".equals(e.getElementsByTagName("resultCode").item(0).getTextContent())) {
	                ok = true;
	            } else {
	                err = e.getElementsByTagName("resultMsg").item(0).getTextContent();
	            }
	        }

	        if (ok) {
	            String fd = null, ft = null; // 가장빠른 예보날짜, 시간 저장
	            String pty = null; // 강수형태
	            String sky = null; // 하늘상태
	            String cat; // category
	            String val; // fcstValue

	            ns = doc.getElementsByTagName("item");
	            for (int i = 0; i < ns.getLength(); i++) {
	                e = (Element) ns.item(i);

	                if (ft == null) {
	                    fd = e.getElementsByTagName("fcstDate").item(0).getTextContent();
	                    ft = e.getElementsByTagName("fcstTime").item(0).getTextContent();
	                } else if (!fd.equals(e.getElementsByTagName("fcstDate").item(0).getTextContent())
	                        || !ft.equals(e.getElementsByTagName("fcstTime").item(0).getTextContent())) {
	                    continue;
	                }

	                cat = e.getElementsByTagName("category").item(0).getTextContent();
	                val = e.getElementsByTagName("fcstValue").item(0).getTextContent();

	                if ("PTY".equals(cat)) pty = val; // 강수형태
	                else if ("SKY".equals(cat)) sky = val; // 하늘상태
	                else if ("T1H".equals(cat)) v[3] = val; // 기온
	                else if ("REH".equals(cat)) v[4] = val; // 습도
	            }

	            v[0] = fd; // 날짜
	            v[1] = ft; // 시간

	            if ("0".equals(pty)) {
	                // 강수형태가 없는 경우, 하늘상태로 판단
	                if ("1".equals(sky)) v[2] = "맑음";
	                else if ("3".equals(sky)) v[2] = "구름많음";
	                else if ("4".equals(sky)) v[2] = "흐림";
	            } else if ("1".equals(pty)) v[2] = "비";
	            else if ("2".equals(pty)) v[2] = "비/눈";
	            else if ("3".equals(pty)) v[2] = "눈";
	            else if ("5".equals(pty)) v[2] = "빗방울";
	            else if ("6".equals(pty)) v[2] = "빗방울눈날림";
	            else if ("7".equals(pty)) v[2] = "눈날림";
	        }

	    } catch (Exception e) {
	        err = e.getMessage();
	        e.printStackTrace();
	    } finally {
	        if (con != null) con.disconnect();
	    }

	    return err;
	}
}
