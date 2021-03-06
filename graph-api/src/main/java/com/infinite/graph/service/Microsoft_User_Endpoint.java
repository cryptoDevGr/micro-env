/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.infinite.graph.service;

import com.infinite.graph.exception.UserTokenExpiredException;
import com.infinite.graph.service.schema.Graph;
import com.microsoft.graph.models.extensions.User;
import org.springframework.stereotype.Service;

/**
 *
 * @author onelove
 */
@Service
public class Microsoft_User_Endpoint extends Graph {

    public Microsoft_User_Endpoint() {
        super();
    }

    public User getUser(String accessToken) throws UserTokenExpiredException {
        try {
            logger.debug("Requesting user information...");
            ensureGraphClient(accessToken);
            // GET /me to get authenticated user
            User me = graphClient
                    .me()
                    .buildRequest()
                    .get();
            return me;
        } catch (com.microsoft.graph.http.GraphServiceException ex) {
            if (ex.getResponseCode() == 401) {
                logger.error("User token has been expired");
                throw new UserTokenExpiredException("User token has been expired");
            }
            return null;
        }
    }
}
