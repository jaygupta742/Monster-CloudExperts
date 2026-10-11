public class Convertor{
//@ joshith  for json response parsing
    public String access_token;
    public String signature;
    public String scope;
    public String instance_url;
    public String id;
    public String token_type;
    public String issued_at;

    
    public static Convertor parse(String json) {
        return (Convertor) System.JSON.deserialize(json, Convertor.class);
    }
}