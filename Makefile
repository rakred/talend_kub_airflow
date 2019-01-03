.PHONY: run build

build:
	docker build -t marodeur100/loadstatetostaging:0.1 --build-arg talend_job=LoadStateToStaging --build-arg talend_version=0.1 .
	docker build -t marodeur100/loadcustomerstostaging:0.1 --build-arg talend_job=LoadCustomersToStaging --build-arg talend_version=0.1 .
	docker build -t marodeur100/loadaggrcustomers:0.1 --build-arg talend_job=LoadAggrCustomers --build-arg talend_version=0.1 .
	docker build -t marodeur100/extractcustomernf:0.1 --build-arg talend_job=ExtractCustomerNF --build-arg talend_version=0.1 .

run_compose:
	docker-compose -f docker-compose-stg.yml up -d

stop_compose:
	docker-compose -f docker-compose-stg.yml down

deploy_dag:
	kubectl get pods	
	echo "sudo kubectl cp dags/talend_kubernetes_example.py <pod>:/root/airflow/dags -c scheduler"

