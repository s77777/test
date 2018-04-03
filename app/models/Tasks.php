<?php

class Tasks extends \Phalcon\Mvc\Model
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
     * @Column(column="priorityid", type="integer", length=4, nullable=true)
     */
    public $priorityid;

    /**
     *
     * @var integer
     * @Column(column="statusid", type="integer", length=4, nullable=true)
     */
    public $statusid;

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
        $this->setSource("tasks");
        $this->hasMany('id', 'TasksTag', 'taskid', ['alias' => 'TasksTag']);
    }

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'tasks';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return Tasks[]|Tasks|\Phalcon\Mvc\Model\ResultSetInterface
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return Tasks|\Phalcon\Mvc\Model\ResultInterface
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
