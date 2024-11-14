package automatedTestCases.api;

import com.intuit.karate.junit5.Karate;

public class testRunner {

    @Karate.Test
    Karate runAll(){
        return Karate.run().relativeTo(getClass());
    }
}
