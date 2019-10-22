for f in ../*.ipynb
do
	echo "Processing $f"
	jupyter nbconvert --to markdown --output-dir . $f
done
