public with sharing class GoogleCalendarService {
    // エンドポイントを定数として宣言
    private static final String ENDPOINT = 'callout:Google_Calendar/primary/events?maxResults=10';
    @AuraEnabled (cacheable=true)
    public static List<Map<String, Object>> getCalenderEvents(){
        try {
            HttpRequest req = new HttpRequest();
            req.setEndpoint(ENDPOINT);
            req.setMethod('GET');

            Http http = new Http();
            HttpResponse res  = http.send(req);

            if (res.getStatusCode() == 200) {
                // 
                Map<String,Object> responseMap = (Map<String,Object>) JSON.deserializeUntyped(res.getBody());
                List<Object> items = (List<Object>) responseMap.get('items');

                List<Map<String,Object>> events = new List<Map<String,Object>>();
                for (Object item : items) {
                    events.add((Map<String,Object>) item);
                }

                return events;
            } else {
                throw new CalloutException('Error: ' + res.getStatusCode() + ' ' + res.getStatus());
            }

        } catch (Exception e) {
            throw new CalloutException(e.getMessage());
        }
    }
}