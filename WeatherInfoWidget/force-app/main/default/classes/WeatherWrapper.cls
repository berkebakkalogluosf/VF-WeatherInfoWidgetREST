/*************************************************************************************
 * @Name         : WeatherWrapper.apxc
 * @Description  : Wrapper class to hold the information from the HTTP callout
 * @Created By   : Berke Bakkaloğlu
 * @Created Date : Sep 01, 2021
 *************************************************************************************/
public class WeatherWrapper {
    
    public class Weather {
        public Integer id;
        public String main;
        public String description {get; set;}
        public String icon {get; set;}
    }
    
    public Coord coord;
    public List<Weather> weather {get; set;}
    public String base;
    public Main main {get; set;}
    public Integer visibility;
    public Wind wind;
    public Clouds clouds;
    public Integer dt;
    public Sys sys;
    public Integer id;
    public String name {get; set;}
    public Integer cod;
    
    public class Coord {
        public Double lon;
        public Double lat;
    }
    
    public class Wind {
        public Double speed;
        public Integer deg;
    }
    
    public class Clouds {
        public Integer all;
    }
    
    public class Sys {
        public Integer type;
        public Integer id;
        public Double message;
        public String country;
        public Integer sunrise;
        public Integer sunset;
    }
    
    public class Main {
        public Double temp {get; set;}
        public Integer pressure;
        public Integer humidity;
        public Double temp_min;
        public Double temp_max;
    }
}