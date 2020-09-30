
# Get the CPU utilization (total) as a percentage (glances server must be running
_get_cpu () {
	python3 -c "import xmlrpc.client, json; print(f'{ json.loads(xmlrpc.client.ServerProxy(\"http://localhost:61209\").getall())[\"quicklook\"][\"cpu\"]/100.0:4.0%}')"
}

_get_ram () {
        python3 -c "import xmlrpc.client, json; print(f'{ json.loads(xmlrpc.client.ServerProxy(\"http://localhost:61209\").getall())[\"quicklook\"][\"mem\"]/100.0:4.0%}')"
}

_get_cpu_mem () {
        python3 -c "import xmlrpc.client, json; _ = json.loads(xmlrpc.client.ServerProxy(\"http://localhost:61209\").getAll()); print(f\"MEM {_['quicklook']['mem']/100.0:4.0%} | CPU {_['quicklook']['cpu']/100.0:4.0%}\")"
}

