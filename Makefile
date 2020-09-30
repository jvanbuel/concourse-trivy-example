.PHONY: clean
.DEFAULT_GOAL := create

NAME := test-pipeline
TARGET := tutorial
URL := http://localhost:8080
CONF := concourse/pipeline.yml


login: 
	fly --target $(TARGET) login \
    --concourse-url $(URL) -b


clean: login
	fly --target $(TARGET) destroy-pipeline \
    --pipeline $(NAME)


create: login
	fly --target $(TARGET) set-pipeline \
	--pipeline $(NAME) \
	--config $(CONF) -n 
	fly --target $(TARGET) unpause-pipeline \
	--pipeline $(NAME)
