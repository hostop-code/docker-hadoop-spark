FROM kevinity310/hadoop-nodemanager:dev

# Install jupyter notebook
RUN pip3 install jupyter

# Create a new system user
RUN useradd -m jupyteruser

# Set the working directory
WORKDIR /home/jupyteruser

# Switch to the newly created user
USER jupyteruser

# Expose the port for Jupyter Notebook (default is 8888)
EXPOSE 8888


# # Set password for Jupyter Notebook
# RUN mkdir -p /home/jupyteruser/.jupyter && \
#     jupyter notebook --generate-config -y && \
#     echo "c.NotebookApp.password = 'sha1:67c9e60bb8b6:9ffede0825894254b2e042ea597d771089b5b418'" >> /home/jupyteruser/.jupyter/jupyter_notebook_config.py && \
#     chmod -R 700 /home/jupyteruser/.jupyter

# Start Jupyter Notebook when the container launches
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--allow-root", "--NotebookApp.token='2wsx1qaz'"]

USER root
# docker build -t kevinity310/jupyter-notebook:dev ./jupyter-notebook

# docker run --rm -p 8888:8888  kevinity310/jupyter-notebook:dev 