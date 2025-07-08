@isTest
private class TestVerifyDate {
  @isTest
  static void testWithin() {
    Date dateTest = VerifyDate.CheckDates(Date.newInstance(2025, 7, 7),Date.newInstance(2025, 7, 8 ));
    System.assertEquals(dateTest, Date.newInstance(2025, 7, 8));
  }
  @isTest
  static void testNotWithin() {
    Date dateTest = VerifyDate.CheckDates(Date.newInstance(2025, 7, 7),Date.newInstance(2025, 12, 12 ));
    System.assertEquals(dateTest, Date.newInstance(2025, 7, 31));
  }

}