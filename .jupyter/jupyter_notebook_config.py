from notebook.auth import passwd

c = get_config()  # noqa: F821

c.JupyterApp.answer_yes = True

c.NotebookApp.open_browser = False
c.NotebookApp.port = 4242

c.NotebookApp.password = passwd('XXX')
c.NotebookApp.password_required = True
c.NotebookApp.allow_password_change = False
