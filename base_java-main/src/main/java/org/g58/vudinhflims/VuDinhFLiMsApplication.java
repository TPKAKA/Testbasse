package org.g58.vudinhflims;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.boot.builder.SpringApplicationBuilder;

@SpringBootApplication
public class VuDinhFLiMsApplication extends SpringBootServletInitializer {

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(VuDinhFLiMsApplication.class);
    }

    public static void main(String[] args) {
        SpringApplication.run(VuDinhFLiMsApplication.class, args);
    }
}
