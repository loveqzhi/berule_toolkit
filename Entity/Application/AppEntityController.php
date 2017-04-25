<?php

/**
 * @file
 *
 * AppEntityController 
 */

namespace Entity\Application;

use Pyramid\Component\Entity\EntityController;
use Entity;
class AppEntityController extends EntityController {
    
    //@inherited attachLoad
    protected function attachLoad(&$query_entities) {
        parent::attachLoad($query_entities);
        foreach ($query_entities as $entity_id => $entity) {
            //to do
            $this->assembleUsers($entity);
        }
    }
    
    //取用户名
    protected function assembleUsers($entity) {

        $entity->username = Entity\User\User::loadUsernameByUid($entity->uid);
    }
    

}
