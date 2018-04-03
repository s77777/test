<?php

class TasksTag extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Primary
     * @Identity
     * @Column(column="id", type="integer", length=10, nullable=false)
     */
    public $id;

    /**
     *
     * @var integer
     * @Column(column="taskid", type="integer", length=10, nullable=false)
     */
    public $taskid;

    /**
     *
     * @var string
     * @Column(column="text", type="string", nullable=true)
     */
    public $text;

    /**
     *
     * @var string
     * @Column(column="timecreate", type="string", nullable=true)
     */
    public $timecreate;

    /**
     *
     * @var integer
     * @Column(column="usercreate", type="integer", length=4, nullable=true)
     */
    public $usercreate;

    /**
     * Initialize method for model.
     */
    public function initialize()
    {
        $this->setSchema("test");
        $this->setSource("tasks_tag");
        $this->belongsTo('taskid', '\Tasks', 'id', ['alias' => 'Tasks']);
    }

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'tasks_tag';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return TasksTag[]|TasksTag|\Phalcon\Mvc\Model\ResultSetInterface
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return TasksTag|\Phalcon\Mvc\Model\ResultInterface
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
