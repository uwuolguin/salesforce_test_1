public class StringListTest {
    public static List<String> generateStringList(Integer num) {
        List<String> stringList = new List<String>();
        
        for (Integer i = 0; i < num; i++) {
            stringList.add('Test ' + i);
        }
        
        return stringList;
    }
}