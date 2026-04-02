# Traditional-Chinese-Char-detector

This repository contains code and data for a Traditional Chinese character detector developed as a final group project for a machine learning course. The project is implemented in MATLAB and includes scripts for preparing data, training a detector, running detection on images, and evaluating results.

**Highlights**

- Detects Traditional Chinese characters in images using a MATLAB-based pipeline.
- Includes labeling project files, training scripts, preprocessing helpers, and evaluation utilities.

**Requirements**

- MATLAB (any modern release with Image Processing Toolbox and Computer Vision Toolbox recommended).

**Quick Start**

1. Open MATLAB and set the project root as the current folder.
2. Prepare or verify images under the `data/` or `data_new/train/` folders.
3. Run training:
   - In MATLAB: `Train` (or open and run `Train.m`).

4. Run the detector on test images or a dataset:
   - In MATLAB: `final` (or open and run `final.m`).

5. Evaluate detector accuracy:
   - In MATLAB: `accuracy` (or open and run `accuracy.m`).

**Main Files**

- `Train.m`: Training script — trains the detector using the prepared training data.
- `final.m`: Runs detection on images / dataset and saves results (outputs often saved under `result/`).
- `accuracy.m`: Computes accuracy/metrics for detection results against ground truth labels.
- `check_image.m`: Utilities to visualize or check per-image detection output.
- `resize.m`: Image resizing/preprocessing helper used to prepare images for training or inference.

**Data & Labeling**

- `data/`: Primary dataset folder. Contains labeling files such as `label.mat`, `label2.mat`, ... and a `train/` folder with an Image Labeler project (`train_LabelingProject`).
- `data_new/`: Additional/updated dataset with `train_label.mat` and `test_label.mat` and a `train/` folder for new images.
- Labeling project files in `LabelingProject` or `train_LabelingProject` are MATLAB Image Labeler projects (GroundTruthProject), useful when re-creating or editing annotations.

**Results**

- `result/`: Contains trained detector files (`detector.mat`, `detector2.mat`, ...). These are model artifacts produced by training scripts.

**Typical Workflow**

1. Prepare images and annotations (use MATLAB Image Labeler to update ground-truth projects in `resources/project/`).
2. Use `resize.m` to standardize image sizes if needed.
3. Run `Train.m` to produce a detector saved to `result/`.
4. Run `final.m` to apply the detector and generate outputs.
5. Run `accuracy.m` to compute performance metrics and inspect results with `check_image.m`.

**How to Add New Data**

1. Place new images in `data_new/train/` (or `data/train/`) following the existing folder organization.
2. Create or update labels using the MATLAB Image Labeler (the project templates are under `train_LabelingProject` and `LabelingProject`).
3. Save or export labels as `.mat` files (e.g., `train_label.mat`) and update training scripts if necessary.

**Tips & Notes**

- The project relies on MATLAB workflows (Image Labeler ground-truth files are included). Familiarity with MATLAB toolboxes (Image Processing and Computer Vision) is helpful.
- If you need to run scripts non-interactively, you can call MATLAB from the command line, for example:

```
matlab -batch "Train"
matlab -batch "final"
matlab -batch "accuracy"
```
