
run:
	sudo kubectl create -f stream.yaml
	sudo kubectl create -f grafana.yaml
	sudo kubectl create -f kafka-connect-ui.yaml

delete:
	sudo kubectl delete namespace stream

get_pods:
	sudo kubectl get pods --namespace=stream

pods_default:
	sudo kubectl get pods --namespace=default


cdc:
	curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:30083/connectors/ -d @es-sink.json
	curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:30083/connectors/ -d @register-postgres.json
	curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:30083/connectors/ -d @register-legacy-source.json

logs:
	POD_NAME="$(shell sudo kubectl get pods -l "app=debezium-connect-source" -o jsonpath="{.items[0].metadata.name}" --namespace=stream)"; sudo kubectl logs $$POD_NAME --namespace=stream
 
sql:
	POD_NAME="$(shell sudo kubectl get pods -l "name=postgres-airflow" -o jsonpath="{.items[0].metadata.name}")"; sudo kubectl exec -it $$POD_NAME psql airflow

change_record:
	POD_NAME="$(shell sudo kubectl get pods -l "name=postgres-airflow" -o jsonpath="{.items[0].metadata.name}")"; sudo kubectl cp change_record.sql "$$POD_NAME":/
	POD_NAME="$(shell sudo kubectl get pods -l "name=postgres-airflow" -o jsonpath="{.items[0].metadata.name}")"; sudo kubectl exec -it $$POD_NAME psql airflow < change_record.sql

generate_msg:
	python stream/kafka_producer.py localhost:30092 test

clean_pods:
	sudo kubectl delete pods --field-selector status.phase!=Running

