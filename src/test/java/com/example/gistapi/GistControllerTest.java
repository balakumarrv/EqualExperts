
package com.example.gistapi;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.server.LocalServerPort;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@AutoConfigureMockMvc
public class GistControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Test
    public void testGetGistsForOctocat() throws Exception {
        mockMvc.perform(get("/octocat"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.gists").isArray());
    }
}
