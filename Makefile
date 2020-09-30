.PHONY: clean
.DEFAULT_GOAL := create

NAME := test-pipeline
TARGET := tutorial
URL := http://localhost:8080
CONF := concourse/pipeline.yml
VARS := .vars.yml


login: 
	fly --target $(TARGET) login \
    --concourse-url $(URL) -b


clean: login
	fly --target $(TARGET) destroy-pipeline \
    --pipeline $(NAME) -n 


create: login
	fly --target $(TARGET) set-pipeline \
	--pipeline $(NAME) \
	--config $(CONF) -n -l $(VARS)
	fly --target $(TARGET) unpause-pipeline \
	--pipeline $(NAME)
