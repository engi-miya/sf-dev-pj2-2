@IsTest
private class GoogleCalendarServiceTest {
    @IsTest
    private static void testGetCalenderEvents() {
        Test.startTest();
            // Gカレンダーが返すJSONデータを用意 (モックデータと呼ぶ)
            String mockResponse = '{"items":[{"id": "event1", "summary": "会議", "start": {"dateTime": "2024-04-01T10:00:00Z"}, "end": {"dateTime": "2024-04-01T11:00"}}]}';
            // モックデータをモックレスポンスに設定
            HttpResponse mockHttpResponse = new HttpResponse();
            mockHttpResponse.setBody(mockResponse);
            mockHttpResponse.setStatusCode(200);

            // モッククラスの設定
            // 外部 API の代わりに「テスト用のダミーレスポンス」を返す
            Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(mockHttpResponse));

            // メソッドの実行
            List<Map<String,Object>> events = GoogleCalendarService.getCalenderEvents();
        Test.stopTest();

        // アサーション
        Assert.areNotEqual(null, events, 'レスポンスがnullでないことを確認。');
        Assert.areEqual(1, events.size(), 'イベントが1件あることを確認。');
        Assert.areEqual('会議', events[0].get('summary'), 'タイトルが会議であることを確認。');
    }

    // モッククラス
    private class MockHttpResponseGenerator implements HttpCalloutMock {
        private HttpResponse response;

        public MockHttpResponseGenerator(HttpResponse res) {
            this.response = res;
        }
        // Http.sendが実行されるとこのメソッドが実行される
        public HttpResponse respond(HttpRequest req) {
            return this.response;
        }
    }
}