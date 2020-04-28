Ideas of ML innovations
======
1. [ ABRT ] Train an optimizer with parameters automatically updated for WGAN.
1. [ ABRT ] Any algorithms to train Discriminator and Generator simultaneously?
1. [ ABRT ] Combining Adam and SGD together? --> In use, but no paper?
1. [      ] Apply static Dropout layers to GAN or other DL structures.
1. [ SUSP ] (Adversarial transfer learning) Training "G1 & D" and G2 separately to get better variation.
    - Clarification:
        - First we train a GAN as a text-to-image task.
        - Then we use the GAN as the teacher to provide training images for the image-to-text generator.
        - The loss is calculated by calculating the distance of original and generated text
    - Aim: If we can transfer previous knowledge (e.g. trained on a novel corpus) to image captioning, etc.
           It will be good to have trained-word-embedding + image = long image caption.
    - **Resources**
        - https://towardsdatascience.com/generative-adverserial-networks-semi-supervised-learning-24f5fb027934
        - https://arxiv.org/search/?query=%22transfer+learning%22+GAN&searchtype=all&abstracts=show&order=-announced_date_first&size=50
1. [ INSP ] Find an approach to solve the shortage of word embedding which interprete each word
            with the context.
            Drawbacks of word embedding:
                - One representation for one word???
            Question: Since the meaning of the word will change in different context, is it available to
               alter the word embedding during training procedure?
               e.g. use the hidden state in RNN to generate incremental data for word embedding.
            We use RNN hidden state to understand the words' meaning given context.
            We use RNN hidden state to give words their meaning in generation procedure given context.
1. [ INSP ] Applying Mode-Seeking Loss ($L_{ms}$, described in MSGAN) to text generation.
1. [      ] Applying Mode-Seeking Loss ($L_{ms}$, described in MSGAN) to sequence augmentation.
1. [      ] Applying Logical learning to NLP
1. [      ] Shock Simulator (use for RL)
1. [      ] Bayes Machine for lab test selection
            Suppose $S_x := Symptom x; T_x := Test x; D := Diseases; det(X) := Deterministic matric for X$.
            Is it able to use prior knowledge $p(S_x), p(D_x), p(S_x|D_x), p(T_x|D_x)$
            to choose $x$ to make $det(p(D_x|S_x, T_k)) - det(p(D_x|S_x))$ ?
1. [      ] ERCP 切开 Oddis 括约肌？肌松药？
1. [      ] Reinforcement Classification: C -> Results -> RL -> Convincing -> Punishment or Reward



ABRT: Aborted
INSP: Inspecting
SUSP: Suspended for difficulty
