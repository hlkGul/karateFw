package examples.education;

import com.intuit.karate.junit5.Karate;

public class educationRunner {
    @Karate.Test
    Karate testUsers(){return Karate.run("education").relativeTo(getClass());}
}
